var myApp = angular.module('businessIncentivesApp');

(function (app) {

    app.controller('rootController', ['$scope', '$http', '$window', '$timeout', '$uibModal', '$rootScope', function ($scope, $http, $window, $timeout, $uibModal, $rootScope) {

        // Field initialization
        var initialize = function () {
            $scope.userLogin = {};
            $scope.loggedInUser = {};
            $scope.isNewUser = false;
            $scope.userLoggedIn = false;
            $scope.showUserModal = false;
            $rootScope.canSubmitOpportunities = false;
        };

        // Initialize fields
        initialize();

        // On click event for "Sign in" button
        $scope.onUserClick = function () {
            $scope.openUserModal();
            $scope.showUserModal = true;
        };

        // Form Modal Open
        $scope.openUserModal = function openUserModal() {
            $scope.modalInstance = $uibModal.open({
                animation: true,
                ariaLabelledBy: 'modal-title',
                ariaDescribedBy: 'modal-body',
                templateUrl: 'userModalView.html',
                controller: 'userModalController',
                controllerAs: 'login',
                centered: true,
                size: 'sm',
                resolve: {
                    userLoggedIn: isUserLoggedIn,
                    loggedInUser: getUser
                }
            });
        };

        // Field initialization
        var init = function () {
            $scope.userLogin = {};
            $scope.loggedInUser = {};
            $scope.isNewUser = false;
            $scope.userLoggedIn = false;
            $scope.showUserModal = false;
            $rootScope.canSubmitOpportunities = false;
        };

        // Callback object
        var getUser = function() {
            return $scope.loggedInUser;
        };

        // Callback object
        var isUserLoggedIn = function () {
            return $scope.userLoggedIn;
        };

        /*** Events watchers ***/
        // Login event callback
        $scope.$on("login", function (event) {
            $scope.login(event.currentScope.$$listeners['login'][0].arguments[1]);
            $scope.showUserModal = false;
        });

        // Logout event callback
        $scope.$on("logout", function (loggedInUser) {
            $scope.logout(loggedInUser);
            $scope.showUserModal = false;
        });

        // Update profile event callback
        $scope.$on("updateProfile", function (event) {
            $scope.updateProfile(event.currentScope.$$listeners['updateProfile'][0].arguments[1]);
            $scope.showUserModal = false;
        });

        // Create User event callback
        $scope.$on("createUser", function (event) {
            $scope.createUser(event.currentScope.$$listeners['createUser'][0].arguments[1]);
            $scope.showUserModal = false;
        });

        // Check for user session on load event callback
        $(document).ready(function () {

            var promise = $http({
                method: "POST",
                url: "/api/getSession",
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                if (result.data.IsSuccess) {
                    $scope.userLoggedIn = result.data.IsSuccess;
                    $scope.loggedInUser.username = result.data.UserName;
                    $scope.loggedInUser.UserFirstName = result.data.UserFirstName;
                }

                if (result.data.PermissionLevelID === null)
                    $scope.logout();
                else
                    $rootScope.canSubmitOpportunities = result.data.PermissionLevelID < 3;
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
                $scope.userLoggedIn = false;
            });
        });

        // Login POST
        $scope.login = function (userLogin) {

            var promise = $http({
                method: "POST",
                url: "/api/login",
                data: userLogin,
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                if (result.data.IsSuccess) {
                    $scope.userLoggedIn = result.data.IsSuccess;
                    $scope.loggedInUser = result.data;
                    $scope.modalInstance.close();

                    if (result.data.PermissionLevelID === null)
                        $rootScope.canSubmitOpportunities = false;
                    else
                        $rootScope.canSubmitOpportunities = result.data.PermissionLevelID < 3;
                }
                else {
                    $window.alert(result.data.ErrorMessage);
                }
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
                $scope.initialize();
            });
        };

        // logout POST
        $scope.logout = function (userLogin) {

            var promise = $http({
                method: "POST",
                url: "/api/logout",
                data: $scope.loggedInUser,
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                if (result.data) {
                    $scope.userLoggedIn = false;
                    $scope.loggedInUser = {};
                    $rootScope.canSubmitOpportunities = false;
                }
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
                $scope.userLoggedIn = false;
            });
        };

        // updateProfile POST
        $scope.updateProfile = function (user) {

            var promise = $http({
                method: "POST",
                url: "/api/updateProfile",
                data: user,
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                if (!result.data.IsSuccess) {
                    $window.alert(result.data.ErrorMessage);
                }
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
                $scope.userLoggedIn = false;
            });
        };

        // createUser POST
        $scope.createUser = function (newUser) {

            var promise = $http({
                method: "POST",
                url: "/api/createUser",
                data: newUser,
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                if (result.data.IsSuccess) {
                    $scope.isNewUserValid = result.data.IsSuccess;
                    $window.alert("User creation successful. You can use your credentials to log in");
                }
                else {
                    $window.alert(result.data.ErrorMessage);
                }
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
                $scope.isNewUserValid = false;
            });
        };
    }]);
})(myApp);

