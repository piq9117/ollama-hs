module Ollama.Api.Types.ModelRecommendation where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data ModelRecommendation
instance Show ModelRecommendation
instance Eq ModelRecommendation
instance Data.Aeson.FromJSON ModelRecommendation
instance Data.Aeson.ToJSON ModelRecommendation
