app = angular.module 'demoControls', [], ->

app.controller 'MainCtrl', ['$scope', ($scope) ->
  $scope.settings =
    modes: window.rgSamples
    currentMode: window.rgSamples[0]
    speed: 100
  $scope.pen = -> roboglyphics.pen

  roboglyphics = new rg.Roboglypics document.getElementsByTagName('canvas')[0], $scope.settings

  $scope.$watch 'settings.currentMode', (nval) ->
    roboglyphics.reset()
    roboglyphics.setPen nval
]