(function () {
    var app = angular.module('businessIncentivesApp');

    app.controller('aboutController', function ($scope, $http, $window, $timeout) {
        $scope.imgUrl = Utils.baseUrl + 'Content/Images/TeamV2.png';
    });
})();

