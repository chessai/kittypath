{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RoleAnnotations #-}

import Data.Semigroup ((<>))

data RFF = Root | Folder | File
  deriving (Eq)

-- | A path is one of the following:
--   Path Root   Folder
--   Path Root   File
--   Path Folder Folder
--   Path Folder File
-- n.b. any path is coercible to any other
newtype Path (s :: RFF) (t :: RFF) = Path { mkPath :: String }

type role Path phantom phantom

unixSlash :: String
unixSlash = "/"

windowsSlash :: String
windowsSlash = "\\"

-- this only works on unix right now
root :: Path Root Folder
root = Path unixSlash 

compose :: (Path a b) -> (Path b c) -> (Path a c)
compose (Path a) (Path b) = Path (a <> "/" <> b)

parseAbsFolder :: String -> Maybe (Path Root Folder)
parseAbsFolder = undefined

parseAbsFile   :: String -> Maybe (Path Root File)
parseAbsFile = undefined

parseRelFolder :: String -> Maybe (Path Folder Folder)
parseRelFolder = undefined

parseRelFile   :: String -> Maybe (Path Folder File)
parseRelFile = undefined

--method of a typeclass that has instances on these 4 types
showPath :: Path a b -> String
showPath = undefined
