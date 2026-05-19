module Ollama.Api.Types.ProcessModelResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ProcessModelResponse
instance Show ProcessModelResponse
instance Eq ProcessModelResponse
instance Data.Aeson.FromJSON ProcessModelResponse
instance Data.Aeson.ToJSON ProcessModelResponse
