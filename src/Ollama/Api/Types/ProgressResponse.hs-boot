module Ollama.Api.Types.ProgressResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ProgressResponse
instance Show ProgressResponse
instance Eq ProgressResponse
instance Data.Aeson.FromJSON ProgressResponse
instance Data.Aeson.ToJSON ProgressResponse
