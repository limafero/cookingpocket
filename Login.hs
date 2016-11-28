{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Login where

import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text
import Database.Persist.Postgresql


postLoginR :: Handler Html
postLoginR = do
            result <- requireJsonBody :: Handler Usuarios
            cara <- runDB $ selectFirst [UsuariosEmail ==. usuariosEmail result,
                                        UsuariosSenha ==. usuariosSenha result] []
            case cara of
                Just (Entity pid pessoa) -> do
                    setSession "_ID" (pack $ show $ fromSqlKey pid)
                    sendResponse (object [pack "id" .= pack (show $ fromSqlKey pid)])
                _ -> sendResponse (object [pack "id" .= pack "erro de login"])

postLogoutR:: Handler Html
postLogoutR = do
    deleteSession "_ID"
    sendResponse (object [pack "resp" .= pack "logout efetuado"])