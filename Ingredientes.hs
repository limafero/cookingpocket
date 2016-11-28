{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Ingredientes where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text


postIngredR :: Handler TypedContent
postIngredR = do
    ingredientes <- requireJsonBody :: Handler Ingredientes
    iid <- runDB $ insert ingredientes
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey iid))])
-- "ingredientes" vai receber uma requisição do JSON, há uma conversão para o tipo Ingredientes
-- e inserir um novo ingrediente. E então responde com uma mensagem de criação.

getListIngredR :: Handler TypedContent
getListIngredR = do
    ingredientes <- runDB $ selectList [] [Asc IngredientesNome]
    sendResponse (object [pack "dados" .= toJSON ingredientes])
-- Recebe uma requisição do Json, há uma conversão para o tipo Ingrediente 
-- e então lista os ingredientes.


