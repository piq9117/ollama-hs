module Spec.GenerateRequest (test_testTree) where

import Ollama.Api.Operations.GenerateCompletion
  ( GenerateCompletionResponse (..),
    generateCompletion,
  )
import Ollama.Api.Types.GenerateRequest
  ( GenerateRequest (..),
    GenerateRequestOptions (..),
    mkGenerateRequest,
    mkGenerateRequestOptions,
  )
import OllamaExample (ManageOllama (..), OllamaExample, OllamaExampleState (..))
import Test.Hspec (describe, it, shouldBe)
import Test.Tasty (TestTree)
import Test.Tasty.Hspec (testSpec)

test_testTree :: OllamaExample TestTree
test_testTree = do
  state <- ask
  let prompt = "You are an expert and veteran haskell developer with 10 years of experience. Create a complete plan for implementing a cli tool that returns 'hello world'"
  res <-
    runOllama
      ( generateCompletion
          ( mkGenerateRequest
              state.model
              prompt
          )
            { generateRequestOptions =
                Just
                  mkGenerateRequestOptions
                    { generateRequestOptionsTemperature = Just 0.2
                    },
              generateRequestContext = Just [8192],
              generateRequestStream = Just False
            }
      )
  liftIO $
    testSpec "GenerateRequestSpec" $
      describe "generate request" $ do
        it "success" $ do
          (isSuccess res) `shouldBe` True
  where
    isSuccess (GenerateCompletionResponse200 _) = True
    isSuccess _ = False
