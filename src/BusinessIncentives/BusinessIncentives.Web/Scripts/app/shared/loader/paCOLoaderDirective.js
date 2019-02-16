angular.module('businessIncentivesApp')
    .directive('biPacoLoader', function ($window) {

        return {
            link: function (scope, element) {
                var trackWidth = Math.floor($(window).width() / 100.0) * 100.0;
                scope.goldCount = Math.floor(trackWidth / 100.0);
                scope.animationDuration = scope.goldCount * ((trackWidth + 30.0) / (200.0 * scope.goldCount));

                // bind to window width and update on resize event
                angular.element($window).on('resize', function ($event) {
                    trackWidth = Math.floor($(window).width() / 100.0) * 100.0;
                    scope.goldCount = Math.floor(trackWidth / 100.0);
                    scope.animationDuration = scope.goldCount * ((trackWidth + 30.0) / (200.0 * scope.goldCount));
                    scope.$apply();
                });

                scope.range = function (range, start = 0) {
                    var list = [];
                    for (var i = start; i < range; i++) { list.push(i); }
                    return list;
                };
            },
            restrict: 'EA',
            templateUrl: Utils.baseUrl + 'Scripts/app/shared/loader/paCOLoaderView.html'
        };
    });

