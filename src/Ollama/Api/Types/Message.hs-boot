module Ollama.Api.Types.Message where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data Message
instance Show Message
instance Eq Message
instance Data.Aeson.FromJSON Message
instance Data.Aeson.ToJSON Message
data MessageRole
instance Show MessageRole
instance Eq MessageRole
instance Data.Aeson.FromJSON MessageRole
instance Data.Aeson.ToJSON MessageRole
