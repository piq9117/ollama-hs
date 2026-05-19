module Ollama.Api.Types.Duration where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data DurationVariants
instance Show DurationVariants
instance Eq DurationVariants
instance Data.Aeson.FromJSON DurationVariants
instance Data.Aeson.ToJSON DurationVariants
type Duration = DurationVariants
