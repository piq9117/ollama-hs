module Ollama.Api.Types.ThinkValue where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ThinkValueOneOf2
instance Show ThinkValueOneOf2
instance Eq ThinkValueOneOf2
instance Data.Aeson.FromJSON ThinkValueOneOf2
instance Data.Aeson.ToJSON ThinkValueOneOf2
data ThinkValueVariants
instance Show ThinkValueVariants
instance Eq ThinkValueVariants
instance Data.Aeson.FromJSON ThinkValueVariants
instance Data.Aeson.ToJSON ThinkValueVariants
type ThinkValue = ThinkValueVariants
