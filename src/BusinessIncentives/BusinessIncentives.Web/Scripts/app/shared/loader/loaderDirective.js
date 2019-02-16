
angular.module('businessIncentivesApp')
        .directive('biLoader', function () {
            return {
                restrict: 'EA',
                templateUrl: Utils.baseUrl + 'Scripts/app/shared/loader/loaderView.html'
            };
        });

