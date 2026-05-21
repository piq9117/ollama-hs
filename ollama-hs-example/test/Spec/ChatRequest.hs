module Spec.ChatRequest (test_testTree) where

import Ollama.Api.Operations.GenerateChat
  ( GenerateChatResponse (..),
    generateChat,
  )
import Ollama.Api.Types.ChatRequest (ChatRequest (..), mkChatRequest)
import Ollama.Api.Types.Message (Message (..), mkMessage)
import OllamaExample (ManageOllama (..), OllamaExample, OllamaExampleState (..))
import Test.Hspec (describe, it, shouldBe)
import Test.Tasty (TestTree)
import Test.Tasty.Hspec (testSpec)

test_testTree :: OllamaExample TestTree
test_testTree = do
  model <- asks (.model)
  res <-
    runOllama
      ( generateChat
          ( mkChatRequest
              [ mkMessage
                  { messageContent = Just "echo 'hello world'. say nothing else"
                  }
              ]
              model
          )
            { chatRequestStream = Just False
            }
      )
  liftIO $
    testSpec "ChatRequestSpec" $
      describe "chat request" $ do
        it "success" $ do
          (isSuccess res) `shouldBe` True
  where
    isSuccess (GenerateChatResponse200 _) = True
    isSuccess _ = False
