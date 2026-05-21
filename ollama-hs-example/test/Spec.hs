module Spec (main) where

import Network.HTTP.Client.Conduit (newManager)
import OllamaExample (OllamaExampleState (..), mkOllamaRunner, runOllamaExample)
import Spec.ChatRequest qualified
import Spec.CheckHealth qualified
import Spec.GenerateRequest qualified
import Test.Tasty (defaultMain, testGroup)

main :: IO ()
main = do
  httpManager <- newManager
  let appState =
        OllamaExampleState
          { httpManager,
            model = "qwen2.5-coder:7b",
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

