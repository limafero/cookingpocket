{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Usuarios where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text


postUsuariosR :: Handler TypedContent
postUsuariosR = do 
    usuarios <- requireJsonBody :: Handler Usuarios
    uid <- runDB $ insert usuarios
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey uid))])

-- "usuarios" vai receber uma requisição do JSON, há uma conversão para o tipo Usuarios
-- e inserir um novo usuário. E então responde com uma mensagem de criação.

