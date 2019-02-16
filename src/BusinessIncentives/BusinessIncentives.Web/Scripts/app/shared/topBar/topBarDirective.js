
angular.module('businessIncentivesApp')
        .directive('biTopBar', function () {
            return {
                restrict: 'E',
                replace: true,
                templateUrl: Utils.baseUrl + 'Scripts/app/shared/topBar/topBarView.html',
                link: function (scope, element, attrs) {
                    scope.hideNavMenu = function () {
                        var element = angular.element(".navbar-collapse");
                        if (element.attr('aria-expanded') === 'true') {
                            element.collapse('toggle');
                        }
                    };
                },
                controller: ['$scope', '$location', topBarDirectiveController]
            };

            function topBarDirectiveController($scope, $location) {
                $scope.getClass = function (path) {
                    return ($location.path().substr(0, path.length) === path) ? 'active' : '';
                }

                var isChrome = !!window.chrome && !!window.chrome.webstore;
                var isFirefox = typeof InstallTrigger !== 'undefined';
                var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification));


                if (!$scope.wasBrowserAlertShown && !isChrome && !isFirefox && !isSafari) {
                    alert('Please use Google Chrome, FireFox or Safari to test this early prototype!');
                }
            }
        });

