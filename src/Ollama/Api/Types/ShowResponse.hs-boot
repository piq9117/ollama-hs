module Ollama.Api.Types.ShowResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ShowResponse
instance Show ShowResponse
instance Eq ShowResponse
instance Data.Aeson.FromJSON ShowResponse
instance Data.Aeson.ToJSON ShowResponse
