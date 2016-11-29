angular.module('starter.services', [])


//  ESSE SERVICE PUXA OS JSONS DO BANCO
.service('Search', function($http) {
  return{
    // PEGA AS TODAS AS RECEITAS DO BANCO
    getRecipes: function(){
      return $http.get('http://jsonplaceholder.typicode.com/posts')
      .then(function(response){

        return response.data;
      });
    },
    // PEGA O ID DA RECEITA CLICADA, PARA EXIBIR OS DETALHES
    get: function(recipeId){
      var recipes = $http.get('http://jsonplaceholder.typicode.com/posts/')
      .then(function(response){

        return response.data;

      });
    },
    //EXEMPLO DE FUNÇÃO PARA PEGAR AS RECEITAS DE ALGUMA CATEGORIA ESPECÍFICA
    //EX: SALGADOS
    //http://jsonplaceholder.typicode.com/posts?userId=1
    getSalgados: function(){
      return $http.get('https://haskellweb-limafero.c9users.io/receitas/listar')
      .then(function(response){
        return response.data.dados;
      });
    }
  }
})
// USADO DE PLACEHOLDER PARA TEXTAR AS BUSCAS
.factory('Receitas',function(){
    var receitas = [{
      id:0,
      name:'Bolo',
      categoria:'Doce',
      ingredientes:['ovo','farinha'],
      utensilios:['Forno','Batedeira'],
      description:'wow'
    },{
      id:1,
      name:'Torta',
      categoria:'Doce',
      ingredientes:['ovo','farinha','manteiga'],
      utensilios:['Forno'],
      description:'wow'
    },{
      id:2,
      name:'Bife',
      categoria:'Salgado',
      ingredientes:['carne','alho','cebola'],
      utensilios:['Fogão'],
      description:'wow'
    },{
      id:3,
      name:'Bolo de carne',
      categoria:'Salgado',
      ingredientes:['carne','alho'],
      utensilios:['Fogão'],
      description:'wow'
    }];
    //RETORNA TODAS AS RECEITAS
    return {
      all: function() {
        return receitas;
      }
    };
})
// FACTORY DOS UTENSÍLIOS
.factory('Utensilios', function() {
//CRIANDO OS UTENSÍLIOS
  var utensilios = [{
    id: 0,
    name: 'Forno',
    possui: false
  }, {
    id: 1,
    name: 'Fogão',
    possui: false
  }, {
    id: 2,
    name: 'Panela de pressão',
    possui: false
  }, {
    id: 3,
    name: 'Microondas',
    possui: false
  }, {
    id: 4,
    name: 'Liquidificador',
    possui: false
  },{
    id:5,
    name: 'Batedeira',
    possui: false
  }];

  return {
    //RETORNA OS UTESNÍLIOS
    all: function() {
      return utensilios;
    },
    //RETORNA OS UTENSÍLIOS QUE ESTÃO MARCADOS
    meusUtensilios: function(){
      var meusUtensilios = [];
      for (var i = 0; i < utensilios.length; i++) {
        if(utensilios[i].possui){
          meusUtensilios.push(utensilios[i].name) ;
          }
      }
      return meusUtensilios;
    }
  };
});
