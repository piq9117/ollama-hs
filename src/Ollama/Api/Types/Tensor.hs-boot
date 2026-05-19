module Ollama.Api.Types.Tensor where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data Tensor
instance Show Tensor
instance Eq Tensor
instance Data.Aeson.FromJSON Tensor
instance Data.Aeson.ToJSON Tensor
