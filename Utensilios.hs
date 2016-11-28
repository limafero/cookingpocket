{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Utensilios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text

postUtensR :: Handler TypedContent
postUtensR = do
    utensilios <- requireJsonBody :: Handler Utensilios
    uid <- runDB $ insert utensilios
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])
-- "utensilios" vai receber uma requisição do JSON, há uma conversão para o tipo Utensilios
-- e inserir um novo utensílio. E então responde com uma mensagem de criação.


getListUtensR :: Handler TypedContent
getListUtensR = do
    utensilios <- runDB $ selectList [] [Asc UtensiliosNome]
    sendResponse (object [pack "dados" .= toJSON utensilios])
-- Recebe uma requisição do Json, há uma conversão para o tipo Utensílio 
-- e então lista os utensilios.
