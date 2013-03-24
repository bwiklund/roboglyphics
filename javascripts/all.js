(function() {
  var app;

  app = angular.module('demoControls', [], function() {});

  app.controller('MainCtrl', [
    '$scope', function($scope) {
      var roboglyphics;
      $scope.settings = {
        modes: window.rgSamples,
        currentMode: window.rgSamples[0],
        speed: 100
      };
      $scope.pen = function() {
        return roboglyphics.pen;
      };
      roboglyphics = new rg.Roboglypics(document.getElementsByTagName('canvas')[0], $scope.settings);
      return $scope.$watch('settings.currentMode', function(nval) {
        roboglyphics.reset();
        return roboglyphics.setPen(nval);
      });
    }
  ]);

}).call(this);
