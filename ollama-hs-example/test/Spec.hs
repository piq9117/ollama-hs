module Spec (main) where

import Network.HTTP.Client.Conduit (newManager)
import OllamaExample (OllamaExampleState (..), mkOllamaRunner, runOllamaExample)
import Spec.ChatRequest qualified
import Spec.CheckHealth qualified
import Spec.GenerateRequest qualified
-- import Conduit (ConduitT, (.|))
-- import Conduit qualified
-- import Control.Exception (try)
-- import Data.ByteString qualified
-- import Network.HTTP.Client.Conduit (HttpException, Response, responseBody)
-- import Ollama.Api.Common (ClientT, MonadHTTP, runWithConfiguration)
-- import Ollama.Api.Configuration (defaultConfiguration)
-- import Ollama.Api.Operations.CheckHealth (CheckHealthResponse (..), checkHealth)
-- import Ollama.Api.Operations.GenerateChat
--   ( GenerateChatResponse (..),
--     generateChat,
--     generateChatRaw,
--   )
-- import Ollama.Api.Operations.GenerateCompletion
--   ( GenerateCompletionResponse (..),
--     generateCompletion,
--     generateCompletionRaw,
--   )
-- import Ollama.Api.Types.ChatRequest (ChatRequest (..), mkChatRequest)
-- import Ollama.Api.Types.ChatResponse (ChatResponse (..))
-- import Ollama.Api.Types.GenerateRequest (GenerateRequest (..), GenerateRequestOptions (..), mkGenerateRequest, mkGenerateRequestOptions)
-- import Ollama.Api.Types.Message (Message (..), MessageRole (..), mkMessage)
-- import Test.Hspec (describe, it, shouldBe)
-- import Test.Hspec.Expectations (expectationFailure)
import Test.Tasty (defaultMain, testGroup)

-- import Test.Tasty.Hspec (testSpec)

main :: IO ()
main = do
  httpManager <- newManager
  let appState =
        OllamaExampleState
          { httpManager,
            model = "Qwen3-Coder-Next",
            ollamaRunner = mkOllamaRunner
          }
  (defaultMain <<< testGroup "Ollama Api Spec")
    =<< sequence
      ( runOllamaExample appState
          <$> [ Spec.ChatRequest.test_testTree,
                Spec.CheckHealth.test_testTree,
                Spec.GenerateRequest.test_testTree
              ]
      )

--   res <- runOllama mkOllamaRunner checkHealth
--   print res
--   test
--
-- model :: Text
-- model = "Qwen3-Coder-Next"
--
-- data OllamaRunner m
--   = (MonadHTTP m) =>
--   OllamaRunner
--   { runOllama_ :: forall a. ClientT m a -> m a
--   }
--
-- mkOllamaRunner :: (MonadHTTP m) => OllamaRunner m
-- mkOllamaRunner =
--   OllamaRunner
--     { runOllama_ = \client -> runWithConfiguration defaultConfiguration client
--     }
--
-- runOllama ::
--   (Monad m) =>
--   OllamaRunner m ->
--   ((MonadHTTP m) => ClientT m (Response a)) ->
--   m a
-- runOllama (OllamaRunner {runOllama_}) ollamaApi =
--   runOllama_ (responseBody <$> ollamaApi)
--
-- test :: IO ()
-- test =
--   (defaultMain <<< testGroup "Ollama Api Golden Test")
--     =<< sequence
--       [ test_testTree
--       ]
--
-- test_testTree :: IO TestTree
-- test_testTree = testSpec "spec" $
--   describe "CheckHealth" $ do
--     it "success" $ do
--       res <- runOllama mkOllamaRunner checkHealth
--       res `shouldBe` CheckHealthResponse200
--     it "generate" $ do
--       res <- ollamaGenerate
--       print res
--       (1 :: Int) `shouldBe` 1
--
-- _ollamaChatRaw :: IO [ByteString]
-- _ollamaChatRaw = do
--   let responseChunk :: ConduitT () ByteString IO ()
--       responseChunk = do
--         chunk <-
--           liftIO $
--             runOllama
--               mkOllamaRunner
--               ( generateChatRaw
--                   ( ( mkChatRequest
--                         [ mkMessage
--                             { messageContent = Just "echo 'hello world'. say nothing else"
--                             }
--                         ]
--                         model
--                     )
--                       { chatRequestStream = Just True
--                       }
--                   )
--               )
--         unless (Data.ByteString.null chunk) $ do
--           Conduit.yield chunk
--           responseChunk
--   Conduit.runConduit $ responseChunk .| Conduit.mapM_C print
--   pure []
--
-- ollamaGenerateRaw :: IO ()
-- ollamaGenerateRaw = do
--   let response :: ConduitT () ByteString IO ()
--       response = do
--         chunk <-
--           liftIO $
--             runOllama
--               mkOllamaRunner
--               ( generateCompletionRaw
--                   ( ( mkGenerateRequest
--                         model
--                         "You are an expert and veteran haskell developer with 10 years of experience. Create a complete plan for implementing an http server"
--                     )
--                       { generateRequestOptions = Just mkGenerateRequestOptions {generateRequestOptionsTemperature = Just 0.2},
--                         generateRequestContext = Just [8192],
--                         generateRequestStream = Just True
--                       }
--                   )
--               )
--         unless (Data.ByteString.null chunk) $ do
--           Conduit.yield chunk
--           response
--   Conduit.runConduit $ response .| Conduit.mapM_C print
--
-- ollamaGenerate :: IO GenerateCompletionResponse
-- ollamaGenerate =
--   runOllama
--     mkOllamaRunner
--     ( generateCompletion
--         ( ( mkGenerateRequest
--               model
--               "You are an expert and veteran haskell developer with 10 years of experience. Create a complete plan for implementing an http server. plan_summary: one-paragraph overview"
--           )
--             { generateRequestOptions = Just mkGenerateRequestOptions {generateRequestOptionsTemperature = Just 0.2},
--               generateRequestContext = Just [8192],
--               generateRequestStream = Just False
--             }
--         )
--     )
--
-- ollamaChat :: IO GenerateChatResponse
-- ollamaChat = do
--   runOllama
--     mkOllamaRunner
--     ( generateChat
--         ( ( mkChatRequest
--               [ mkMessage
--                   { messageContent = Just "You are an expert and veteran haskell developer with 10 years of experience. Create a complete plan for implementing an http server",
--                     -- messageContent = Just "echo 'hello world'",
--                     messageRole = Just MessageRoleEnumUser
--                   }
--               ]
--               "qwen2.5-coder:7b"
--           )
--             { chatRequestStream = Just False
--             }
--         )
--     )
