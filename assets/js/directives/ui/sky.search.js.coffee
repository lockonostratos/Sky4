Sky.directive 'skySearch', ->
  obj =
    restrict: 'E'
    templateUrl: 'templates/directives/ui/select.html'
    scope:
      sourceUrl: '@'
      model: '='
      search: '='
      caption: '@'
      width: '@'
      change: '&'
