{-# LANGUAGE DerivingStrategies #-}

module OllamaExample
  ( OllamaExample (..),
    OllamaExampleState (..),
    OllamaRunner (..),
    ManageOllama (..),
    mkOllamaRunner,
    runOllamaExample,
  )
where

import Network.HTTP.Conduit (Manager, responseBody, responseTimeoutNone)
import Network.HTTP.Simple (Response, setRequestManager, setRequestResponseTimeout)
import Network.HTTP.Simple qualified
import Ollama.Api.Common (ClientT (..), MonadHTTP (..), runWithConfiguration)
import Ollama.Api.Configuration (defaultConfiguration)

newtype OllamaExample a = OllamaExample
  { unOllamaExample :: ReaderT OllamaExampleState IO a
  }

runOllamaExample :: OllamaExampleState -> OllamaExample a -> IO a
runOllamaExample state action =
  runReaderT (unOllamaExample action) state

data OllamaExampleState = OllamaExampleState
  { httpManager :: Manager,
    model :: Text,
    ollamaRunner :: forall m. (MonadHTTP m) => OllamaRunner m
  }

deriving newtype instance Functor OllamaExample

deriving newtype instance Applicative OllamaExample

deriving newtype instance Monad OllamaExample

deriving newtype instance MonadIO OllamaExample

instance MonadReader OllamaExampleState OllamaExample where
  ask = OllamaExample ask
  local f action = OllamaExample $ do
    local (\env -> f env) (unOllamaExample action)

instance MonadHTTP OllamaExample where
  httpBS req = do
    OllamaExampleState {httpManager} <- ask
    Network.HTTP.Simple.httpBS $
      setRequestResponseTimeout responseTimeoutNone $
        setRequestManager httpManager req

instance ManageOllama OllamaExample where
  ollama = do
    OllamaExampleState {ollamaRunner} <- ask
    pure ollamaRunner

data OllamaRunner m
  = (MonadHTTP m) =>
  OllamaRunner
  { runOllama_ :: forall a. ClientT m a -> m a
  }

mkOllamaRunner :: (MonadHTTP m) => OllamaRunner m
mkOllamaRunner =
  OllamaRunner
    { runOllama_ = \client -> runWithConfiguration defaultConfiguration client
    }

class ManageOllama m where
  ollama :: m (OllamaRunner m)
  runOllama :: (MonadIO m) => ((MonadHTTP m) => ClientT m (Response a)) -> m a
  runOllama request = do
    o <- ollama
    runOllamaRequest o request

runOllamaRequest ::
  (Monad m) =>
  OllamaRunner m ->
  ((MonadHTTP m) => ClientT m (Response a)) ->
  m a
runOllamaRequest (OllamaRunner {runOllama_}) ollamaApi =
  runOllama_ (responseBody <$> ollamaApi)
