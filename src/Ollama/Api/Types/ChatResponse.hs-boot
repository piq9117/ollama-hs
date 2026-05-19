module Ollama.Api.Types.ChatResponse where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ChatResponse
instance Show ChatResponse
instance Eq ChatResponse
instance Data.Aeson.FromJSON ChatResponse
instance Data.Aeson.ToJSON ChatResponse
data ChatResponseDone_reason
instance Show ChatResponseDone_reason
instance Eq ChatResponseDone_reason
instance Data.Aeson.FromJSON ChatResponseDone_reason
instance Data.Aeson.ToJSON ChatResponseDone_reason
