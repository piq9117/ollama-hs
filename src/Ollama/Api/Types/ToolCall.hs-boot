module Ollama.Api.Types.ToolCall where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ToolCall
instance Show ToolCall
instance Eq ToolCall
instance Data.Aeson.FromJSON ToolCall
instance Data.Aeson.ToJSON ToolCall
data ToolCallFunction
instance Show ToolCallFunction
instance Eq ToolCallFunction
instance Data.Aeson.FromJSON ToolCallFunction
instance Data.Aeson.ToJSON ToolCallFunction
