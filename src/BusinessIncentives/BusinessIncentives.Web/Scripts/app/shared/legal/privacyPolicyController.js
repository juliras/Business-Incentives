(function () {
    var app = angular.module('businessIncentivesApp');

    app.controller('privacyPolicyController', function ($scope, $http, $window, $uibModal) {
        $scope.baseUrl = Utils.baseUrl + 'Scripts/app/shared/legal/privacyPolicyView.html';

    });
})();

