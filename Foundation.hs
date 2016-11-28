{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable, EmptyDataDecls,
             GeneralizedNewtypeDeriving, ViewPatterns, FlexibleInstances #-}
module Foundation where

import Yesod
import Data.Text
import Database.Persist.Postgresql
    ( ConnectionPool, SqlBackend, runSqlPool)

data App = App {connPool :: ConnectionPool }

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Usuarios json
    nome    Text
    email   Text
    senha   Text

Ingredientes json
    nome        Text
    descricao   Text
    
Utensilios json
    nome        Text
    descricao   Text
    
Receitas json
    nome        Text
    descricao   Text
    categoria   Text
    
-- listagem das tabelas e dos campos
    
ReceitasIngredientes json
    receitaid   ReceitasId
    ingredid    IngredientesId
    UniqueReceitasIngredientes receitaid ingredid
    
ReceitasUtensilios json
    receitaid   ReceitasId
    utensid     UtensiliosId
    UniqueReceitasUntensilios receitaid utensid
    
-- essas tabelas vão receber a PK das tabelas Ingredientes e Utensilios.
-- por isso recebem o tipo como o nome da tabela que se relaciona. (FK)

|]

mkYesodData "App" $(parseRoutesFile "routes")


instance Yesod App where
    authRoute _ = Just LoginR
    
    isAuthorized LoginR _ = return Authorized
    isAuthorized UsuariosR _ = return Authorized
    isAuthorized _ _ = return Authorized
    --isAuthorized _ _ = estaAutenticado

estaAutenticado :: Handler AuthResult
estaAutenticado = do
   msu <- lookupSession "_ID"
   case msu of
       Just _ -> return Authorized
       Nothing -> return AuthenticationRequired



instance YesodPersist App where
   type YesodPersistBackend App = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool
       
       
type Form a = Html -> MForm Handler (FormResult a, Widget)

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

