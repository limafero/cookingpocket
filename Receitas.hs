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
    receitas <- requireJsonBody :: Handler Receitas
    rid <- runDB $ insert receitas
    sendResponse (object [pack "resp" .= pack ("CREATED " ++ (show $ fromSqlKey rid))])
-- "receitas" vai receber uma requisição do JSON, há uma conversão para o tipo Receita
-- e inserir uma nova receita. E então responde com uma mensagem de criação.


--copiado do hask3 do garcia

postMontagemR :: Handler TypedContent
postMontagemR = do
    mlista <- requireJsonBody :: Handler Montagem
    listaIng <- return $ ingrids mlista
    listaUtens <- return $ utensids mlista
    receid <- return $ idReceita mlista
    sequence $ Prelude.map (runDB . insert . (ReceitasIngredientes receid)) listaIng
    sequence $ Prelude.map (runDB . insert . (ReceitasUtensilios receid)) listaUtens
    sendResponse (object [pack "resp" .= pack "CREATED: Receita Montada "])
-- linha 25 lê o json e passa para o tipo montagem
-- o tipo montagem tem o id da receita e duas listas com os ids de Ingredientes e Utensilios
-- nas linhas 26, 27 e 28 extrai os campos do tipo montagem
-- o comando return põe na monad handler
-- preciso de um sequence e um map pois tenho uma ação no banco que vai ser executado em listas
-- linha 31 manda a resposta de criação.
    


    
    

