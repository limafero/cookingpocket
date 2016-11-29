{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Receitas where

import Foundation
import Yesod
import Database.Persist.Postgresql
import Data.Text
import Tipos

postReceitasR :: Handler TypedContent
postReceitasR = do
    addHeader "Access-Control-Allow-Origin" "*"
    receitas <- requireJsonBody :: Handler Receitas
    rid <- runDB $ insert receitas
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey rid))])
-- "receitas" vai receber uma requisição do JSON, há uma conversão para o tipo Receita
-- e inserir uma nova receita. E então responde com uma mensagem de criação.

getListReceitaR :: Handler TypedContent
getListReceitaR = do
    addHeader "Access-Control-Allow-Origin" "*"
    receitas <- runDB $ selectList [] [Asc ReceitasNome]
    sendResponse (object [pack "dados" .= toJSON receitas])
--copiado do hask3 do garcia

postMontagemR :: Handler TypedContent
postMontagemR = do
    addHeader "Access-Control-Allow-Origin" "*"
    mlista <- requireJsonBody :: Handler Montagem
    listaIng <- return $ ingrids mlista
    listaUtens <- return $ utensids mlista
    receid <- return $ idReceita mlista
    sequence $ Prelude.map (runDB . insert . (ReceitasIngredientes receid)) listaIng
    sequence $ Prelude.map (runDB . insert . (ReceitasUtensilios receid)) listaUtens
    sendResponse (object [pack "resp" .= pack "CREATED: Receita Montada "])
-- linha 27 lê o json e passa para o tipo montagem
-- o tipo montagem tem o id da receita e duas listas com os ids de Ingredientes e Utensilios
-- nas linhas 28, 29 e 30 extrai os campos do tipo montagem
-- o comando return põe na monad handler
-- preciso de um sequence e um map pois tenho uma ação no banco que vai ser executado em listas
-- linha 33 manda a resposta de criação.

-- "Access-Control-Allow-Origin" "*"
-- O javascript não consegue fazer chamadas que nem o curl,
-- entao tem que adicionar o header para a resposta (CORS)
-- define meios para um servidor permitir que seus recursos 
-- sejam acessados por uma página web de um domínio diferente
    




    
    

