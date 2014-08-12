Sky.directive 'skyTab', ->
  obj =
    restrict: 'E'
    templateUrl: 'templates/directives/ui/tab.html'
    scope:
      options: '='
      model: '='
      caption: '@'
      change: '&'
      delete: '&'
      create: '&'

    controller: ($scope, $element, $attrs) ->
      $scope.colors = []
      $scope.model ?= $scope.options[0]

      $scope.selectTab = (item) ->
        if $scope.model != item
          $scope.model = item
          $scope.change({tab: item})