
angular.module('businessIncentivesApp')
    .directive('biMapLegend', function () {
        return {
            restrict: 'E',
            scope: false,
            templateUrl: Utils.baseUrl + 'Scripts/app/shared/maps/mapLegendView.html'
        };
    });

