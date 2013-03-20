(function() {
  var app;

  app = angular.module('demoControls', [], function() {});

  app.controller('MainCtrl', function($scope) {
    var roboglyphics;
    $scope.settings = {
      modes: rg.modes,
      currentMode: rg.modes[0],
      speed: 100
    };
    roboglyphics = new rg.Roboglypics(document.getElementsByTagName('canvas')[0], $scope.settings);
    return $scope.$watch('settings.currentMode', function(nval) {
      return roboglyphics.pen = null;
    });
  });

}).call(this);
