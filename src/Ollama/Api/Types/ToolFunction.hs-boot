module Ollama.Api.Types.ToolFunction where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ToolFunction
instance Show ToolFunction
instance Eq ToolFunction
instance Data.Aeson.FromJSON ToolFunction
instance Data.Aeson.ToJSON ToolFunction
data ToolFunctionParameters
instance Show ToolFunctionParameters
instance Eq ToolFunctionParameters
instance Data.Aeson.FromJSON ToolFunctionParameters
instance Data.Aeson.ToJSON ToolFunctionParameters
