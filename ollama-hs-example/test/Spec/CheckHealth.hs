module Spec.CheckHealth (test_testTree) where

import Ollama.Api.Operations.CheckHealth (CheckHealthResponse (..), checkHealth)
import OllamaExample (ManageOllama (..), OllamaExample)
import Test.Hspec (describe, it, shouldBe)
import Test.Tasty (TestTree)
import Test.Tasty.Hspec (testSpec)

test_testTree :: OllamaExample TestTree
test_testTree = do
  res <- runOllama checkHealth
  liftIO $
    testSpec "CheckHealthSpec" $
      describe "check health" $ do
        it "success" $ do
          res `shouldBe` CheckHealthResponse200
