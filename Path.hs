{-# LANGUAGE CPP                        #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DeriveDataTypeable         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE KindSignatures             #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RoleAnnotations            #-}

{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -fno-warn-unticked-promoted-constructors #-}

import Data.ByteString
import Data.Data (Data)
import Control.DeepSeq (NFData)

#if !MIN_VERSION_base(4,11,0)
import Data.Monoid (Monoid)
import Data.Semigroup (Semigroup, (<>))
#endif
import Data.String (IsString)

data RFF = Root | Folder | File
  deriving (Eq)

-- | A path is one of the following:
--   Path Root   Folder
--   Path Root   File
--   Path Folder Folder
--   Path Folder File
-- n.b. any path is coercible to any other
newtype Path (s :: RFF) (t :: RFF) = Path { mkPath :: ByteString }
  deriving (Eq, Data, Ord, Read, Show, IsString, Semigroup, Monoid, NFData)

type role Path phantom phantom

unixSlash :: ByteString
unixSlash = "/"

windowsSlash :: ByteString
windowsSlash = "\\"

-- this only works on unix right now
root :: Path Root Folder
root = Path unixSlash 

compose :: (Path a b) -> (Path b c) -> (Path a c)
compose (Path a) (Path b) = Path (a <> "/" <> b)

parseAbsFolder :: ByteString -> Maybe (Path Root Folder)
parseAbsFolder = undefined

parseAbsFile   :: ByteString -> Maybe (Path Root File)
parseAbsFile = undefined

parseRelFolder :: ByteString -> Maybe (Path Folder Folder)
parseRelFolder = undefined

parseRelFile   :: ByteString -> Maybe (Path Folder File)
parseRelFile = undefined

--method of a typeclass that has instances on these 4 types
showPath :: Path a b -> ByteString
showPath = undefined
