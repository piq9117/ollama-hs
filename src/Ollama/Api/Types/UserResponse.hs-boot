module Ollama.Api.Types.UserResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data UserResponse
instance Show UserResponse
instance Eq UserResponse
instance Data.Aeson.FromJSON UserResponse
instance Data.Aeson.ToJSON UserResponse
