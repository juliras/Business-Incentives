(function () {
    var app = angular.module('businessIncentivesApp');
   
    app.controller('submitOpportunityController', ['$scope', '$http', '$rootScope', 'referenceDataService', function ($scope, $http, $rootScope, referenceDataService) {

        $scope.initializeForm = initializeForm;
        $scope.submitOpportunity = function submitOpportunity() {

            $scope.isLoading = true;

            var promise = $http({
                method: "POST",
                url: "/api/customopportunity",
                data: $scope.opportunity,
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                $scope.isLoading = false;
                $scope.opportunityID = result.data.OpportunityID;

                if ($scope.opportunityID === null)
                    alert("Entry not accepted");
                else {
                    alert("Entry accepted");
                    $scope.initializeForm();
                }
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
            });
        };

        $scope.initializeForm();

        function initializeForm() {
            $scope.opportunity = {};
            $scope.formData = {
                assistanceTypes: referenceDataService.assistanceTypes,
                fundingLevels: referenceDataService.fundingLevels
            };
        }

        // Alert for incorrect permissions
        $scope.closeAlert = function (index) {
            $scope.alerts.splice(index, 1);
        };
    }]);
})();
