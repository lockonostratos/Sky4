#= require vendors/angular
#= require_tree ./vendors
#= require_self
#= require_tree ./controllers/global
#= require_tree ./controllers

window.Sky = angular.module 'Sky', ['ngRoute']