module Ollama.Api.Types.ChatRequest where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ChatRequest
instance Show ChatRequest
instance Eq ChatRequest
instance Data.Aeson.FromJSON ChatRequest
instance Data.Aeson.ToJSON ChatRequest
data ChatRequestFormatVariants
instance Show ChatRequestFormatVariants
instance Eq ChatRequestFormatVariants
instance Data.Aeson.FromJSON ChatRequestFormatVariants
instance Data.Aeson.ToJSON ChatRequestFormatVariants
