angular.module('starter.controllers', [])

.filter('myFilter',function(){
  return function(recipes, inputText){
    var retorno = [];


    if (inputText != undefined && inputText != ""){
      var params = inputText;
      var inputMatch = new RegExp(inputText,'i');
      var teste = params.split(',');


      for (var i=0; i<recipes.length;i++){
        var isMatch = recipes[i];
        if (inputMatch.test(isMatch.ingredientes)){
          retorno.push(isMatch);
        }
      }
//  console.log('passei no primeiro');
//  console.log("valor do input: "+inputText);
    } else {
//      console.log('passei no segunda condição, devo estar exibindo todas as receitas');
      retorno = recipes;
    }
    return retorno;
  };
})

.controller('DashCtrl', function($scope) {})

.controller('SearchCtrl', function($scope, Search, Receitas,Utensilios) {
//  Search.getRecipes()
//    .then(function(response){
//      $scope.recipes = response;
//    });

  //TODA VEZ QUE A VIEW FOR ACESSADA, A VARIAVEL DE UTENSÍLIOS MARCADOS
  //É RECALCULADA
  $scope.$on('$ionicView.enter',function(){
    $scope.meusUtensilios = Utensilios.meusUtensilios();
    $scope.recipes = Receitas.all();
  });


  // APLICA O FILTRO DOS UTENSÍLIOS MARCADOS, ESCONDENDO AS RECEITAS
  // QUE USAM UTENSÍLIOS NÃO MARCADOS
  $scope.utensiliosMatch = function(meusUtensilios,utensiliosReceita){
    var retorno = false;
    angular.forEach(utensiliosReceita,function(utensilio,key){
      if (meusUtensilios.indexOf(utensilio) == -1) {
        retorno = true;
     }
   });
    return retorno;
  };

  Search.getSalgados()
    .then(function(response){
      $scope.salgados = response;
      console.log(response);
    });




})
// PEGA O ID DA RECEITA CLICADA E PASSA PARA A VIEW DE DETALHE DA RECEITA
.controller('RecipeDetailCtrl', function($scope, $stateParams, Search) {
  var recipes = Search.getSalgados()
   .then(function(response){
     $scope.recipe = response[$stateParams.recipeId - 1];
   });

})
// DEFINE OS UTENSÍLIOS
.controller('AccountCtrl', function($scope, Utensilios) {
  $scope.utensilios = Utensilios.all();
});
