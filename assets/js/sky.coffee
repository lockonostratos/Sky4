#= require vendors/angular/angular
#= require_tree ./vendors/angular
#= require_tree ./vendors
#= require_self
#= require sky.system
#= require_tree ./services
#= require_tree ./filters
#= require_tree ./directives
#= require_tree ./controllers/global
#= require_tree ./controllers/messenger

window.Sky = angular.module 'Sky', ['ngRoute', 'ui.bootstrap', 'ngAnimate', 'xeditable', 'ui.utils']