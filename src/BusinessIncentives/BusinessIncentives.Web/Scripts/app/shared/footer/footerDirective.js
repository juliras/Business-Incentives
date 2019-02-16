
angular.module('businessIncentivesApp')
        .directive('biFooter', function () {
            return {
                restrict: 'E',
                replace: true,
                templateUrl: Utils.baseUrl + 'Scripts/app/shared/footer/footerView.html',
                link: function(scope, element, attrs) {
                    scope.currentYear = Utils.constants.currentYear;
                }
            };
        });

