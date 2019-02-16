var myApp = angular.module('businessIncentivesApp');

(function (app) {

    app.controller('userModalController', ['$scope', '$uibModalInstance', '$rootScope', '$uibResolve', function ($scope, $uibModalInstance, $rootScope, $uibResolve) {

        $scope.userLogin = {};
        $scope.newUser = $scope.$resolve.loggedInUser;
        $scope.isNewUser = false;
        $scope.userLoggedIn = $scope.$resolve.userLoggedIn;
                
        $scope.okLogin = function (args) {
            $rootScope.$broadcast("login", args);
        };

        $scope.cancel = function () {
            if ($scope.isNewUser)
                $scope.isNewUser = false;
            else
                $uibModalInstance.close();
        };

        $scope.okLogout = function (user) {
            $rootScope.$broadcast("logout", user);
            $uibModalInstance.close();
        };

        $scope.updateProfile = function (user) {
            $rootScope.$broadcast("updateProfile", user);
            $uibModalInstance.close();
        };

        $scope.showNewUser = function () {
            $scope.isNewUser = true;
        };

        $scope.submitOnEnterKey = function (event) {
            if (event.key === 'Enter') {
                if ($scope.isNewUser) {
                    $scope.createUser($scope.newUser);
                }
                else {
                    if ($scope.userLoggedIn)
                        $scope.cancel();
                    else
                        $scope.okLogin($scope.userLogin);
                }
            }
        };

        $scope.createUser = function (newUser) {
            if (newUser.username === undefined) {
                alert("Username is a required field");
                return;
            }
            if (newUser.password === undefined) {
                alert("Password is a required field");
                return;
            }
            if (newUser.email === undefined) {
                alert("Email is a required field");
                return;
            }
            if (newUser.firstname === undefined) {
                alert("First Name is a required field");
                return;
            }
            if (newUser.lastname === undefined) {
                alert("Last Name is a required field");
                return;
            }

            $rootScope.$broadcast("createUser", newUser);
            $uibModalInstance.close();
        };
    }]);
})(myApp);