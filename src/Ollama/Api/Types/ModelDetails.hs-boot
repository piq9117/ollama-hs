module Ollama.Api.Types.ModelDetails where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ModelDetails
instance Show ModelDetails
instance Eq ModelDetails
instance Data.Aeson.FromJSON ModelDetails
instance Data.Aeson.ToJSON ModelDetails
