(function () {
    var app = angular.module('businessIncentivesApp');

    app.controller('homeController', function ($scope, $http, $window, $timeout) {
        $scope.imgUrl = Utils.baseUrl + 'Content/Images/Business Incentives Dark Blue Brochure Tagline.png';
    });
})();

