{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Tipos where
import Data.Text
import Data.Aeson
import GHC.Generics
import Foundation

data Montagem = Montagem {idReceita :: ReceitasId, 
                          ingrids :: [IngredientesId],
                          utensids :: [UtensiliosId]} deriving (Show, Generic, Read)
-- cria o tipo "Montagem", como todos os atributos e seus respectivos tipos, para o cadastro.
-- O idReceita possui o tipo ReceitasId, ingrids possui o tipo IngredientesId 
-- e utensids possui o tipo UtensiliosId.

instance FromJSON Montagem
instance ToJSON Montagem