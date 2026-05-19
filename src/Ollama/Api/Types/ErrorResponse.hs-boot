module Ollama.Api.Types.ErrorResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ErrorResponse
instance Show ErrorResponse
instance Eq ErrorResponse
instance Data.Aeson.FromJSON ErrorResponse
instance Data.Aeson.ToJSON ErrorResponse
