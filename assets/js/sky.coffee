#= require vendors/angular/angular
#= require_tree ./vendors/angular
#= require_tree ./vendors
#= require_self
#= require sky.system
#= require_tree ./services
#= require_tree ./filters
#= require_tree ./directives
#= require_tree ./controllers/global
#= require_tree ./controllers

window.Sky = angular.module 'Sky', ['ngRoute', 'ui.bootstrap', 'ngAnimate', 'xeditable', 'ui.utils']
Sky.gs = (name) -> angular.element(document.body).injector().get(name)
moment.lang 'vi'


Sky.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/', {
      templateUrl: 'templates/home/index.html'
      controller: 'Sky.indexCtrl'
    }).when('/sales', {
      templateUrl: 'templates/sales/home.html'
      controller: 'salesCtrl'
      controllerAs: 'salesCtrl'
    }).when('/sale', {
      templateUrl: 'templates/sales/sale.html'
      controller: 'saleCtrl'
      controllerAs: 'saleCtrl'
    }).when('/sale/delivery', {
      templateUrl: 'templates/sales/delivery.html'
      controller: 'deliveryCtrl'
      controllerAs: 'deliveryCtrl'
    }).when('/sale/return', {
      templateUrl: 'templates/sales/return.html'
      controller: 'returnCtrl'
      controllerAs: 'returnCtrl'
    }).when('/post/:postId',  {
      templateUrl: 'templates/home/post.html'
      controller: 'Sky.postCtrl'
    }).when('/warehouse/import', {
      templateUrl: 'templates/warehouse/import.html',
      controller: 'importCtrl'
      controllerAs: 'importCtrl'
    }).when('/warehouse/inventory', {
      templateUrl: 'templates/warehouse/inventory.html',
      controller: 'inventoryCtrl'
      controllerAs: 'inventoryCtrl'
    }).when('/warehouse/list', {
      templateUrl: 'templates/warehouse/list.html',
      controller: 'listCtrl'
      controllerAs: 'listCtrl'
    }).otherwise( {
      templateUrl: 'templates/global/404.html'
    })
]