(function () {
    var app = angular.module('businessIncentivesApp');

    app.controller('tosController', function ($scope, $http, $window, $uibModal) {
        $scope.baseUrl = Utils.baseUrl + 'Scripts/app/shared/legal/tosView.html';

    });
})();

