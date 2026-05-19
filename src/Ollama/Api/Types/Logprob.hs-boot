module Ollama.Api.Types.Logprob where
import qualified Data.Aeson
import qualified Ollama.Api.Common
data Logprob
instance Show Logprob
instance Eq Logprob
instance Data.Aeson.FromJSON Logprob
instance Data.Aeson.ToJSON Logprob
data LogprobTop_logprobs
instance Show LogprobTop_logprobs
instance Eq LogprobTop_logprobs
instance Data.Aeson.FromJSON LogprobTop_logprobs
instance Data.Aeson.ToJSON LogprobTop_logprobs
