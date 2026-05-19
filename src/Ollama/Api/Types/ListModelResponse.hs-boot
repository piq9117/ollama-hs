module Ollama.Api.Types.ListModelResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ListModelResponse
instance Show ListModelResponse
instance Eq ListModelResponse
instance Data.Aeson.FromJSON ListModelResponse
instance Data.Aeson.ToJSON ListModelResponse
