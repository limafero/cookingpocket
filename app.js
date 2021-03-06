// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic', 'starter.controllers', 'starter.services'])

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider) {

  // Ionic uses AngularUI Router which uses the concept of states
  // Learn more here: https://github.com/angular-ui/ui-router
  // Set up the various states which the app can be in.
  // Each state's controller can be found in controllers.js
  $stateProvider

  // setup an abstract state for the tabs directive
    .state('tab', {
    url: '/tab',
    abstract: true,
    templateUrl: 'templates/tabs.html'
  })

  // Each tab has its own nav history stack:

  .state('tab.dash', {
    url: '/dash',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-dash.html',
        controller: 'DashCtrl'
      }
    }
  })

  .state('tab.salgados',{
    url: '/salgados',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-salgados.html',
        controller: 'SearchCtrl'
      }
    }
  })

  .state('tab.doces',{
    url: '/doces',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-doces.html',
        controller: 'SearchCtrl'
      }
    }
  })

  .state('tab.rapidos',{
    url: '/rapidos',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-rapidos.html',
        controller: 'SearchCtrl'
      }
    }
  })

  .state('tab.salgadoces',{
    url: '/salgadoces',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-salgadoces.html',
        controller: 'SearchCtrl'
      }
    }
  })

  .state('tab.search', {

      url: '/search',
      views: {
        'tab-search': {
          templateUrl: 'templates/tab-search.html',
          controller: 'SearchCtrl'
        }
      }
    })
    .state('tab.recipe-detail', {
      url: '/search/:recipeId',
      views: {
        'tab-search': {
          templateUrl: 'templates/recipe-detail.html',
          controller: 'RecipeDetailCtrl'
        },
      }
    })

    .state('tab.salgado-detail',{
      url:'/salgados/:recipeId',
      views: {
        'tab-dash':{
          templateUrl: 'templates/recipe-detail.html',
          controller: 'RecipeDetailCtrl'
        }
      }
    })

    .state('tab.doce-detail',{
      url:'/doces/:recipeId',
      views: {
        'tab-dash':{
          templateUrl: 'templates/recipe-detail.html',
          controller: 'RecipeDetailCtrl'
        }
      }
    })

    .state('tab.rapido-detail',{
      url:'/rapidos/:recipeId',
      views: {
        'tab-dash':{
          templateUrl: 'templates/recipe-detail.html',
          controller: 'RecipeDetailCtrl'
        }
      }
    })

    .state('tab.salgadoce-detail',{
      url:'/salgadoces/:recipeId',
      views: {
        'tab-dash':{
          templateUrl: 'templates/recipe-detail.html',
          controller: 'RecipeDetailCtrl'
        }
      }
    })

  .state('tab.account', {
    url: '/account',
    views: {
      'tab-account': {
        templateUrl: 'templates/tab-account.html',
        controller: 'AccountCtrl'
      }
    }
  })

  .state('login', {
      url: '/login',
      templateUrl: 'templates/login.html',
      controller: 'LoginCtrl'
  })

  .state('cadastro',{
      url: '/cadastro',
      templateUrl: 'templates/cadastro.html'
  });

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/tab/dash');

});
