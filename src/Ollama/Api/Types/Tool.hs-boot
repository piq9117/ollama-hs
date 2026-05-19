module Ollama.Api.Types.Tool where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data Tool
instance Show Tool
instance Eq Tool
instance Data.Aeson.FromJSON Tool
instance Data.Aeson.ToJSON Tool
