angular.module('businessIncentivesApp')
    .service('searchBusinessService', ['$http', function ($http) {
        var getBusinessNames = function (searchTerm) {

            var promise = $http({
                method: "GET",
                url: "/api/searchBusiness/coloradobusinessnames",
                params: {
                    searchTerm: searchTerm
                }
            }).then(function (result) {
                return result.data;
            })['catch'](function (result) {
                $window.alert(result.statusText);
            });

            return promise;
        };

        var getBusiness = function (businessName) {
            var promise = $http({
                method: "GET",
                url: "/api/searchBusiness/coloradobusiness",
                params: {
                    businessName: businessName
                }
            }).then(function (result) {
                return result.data;
            })['catch'](function (result) {
                $window.alert(result.statusText);
            });

            return promise;
        };

        

        return {
            getBusinessNames: getBusinessNames,
            getBusiness: getBusiness
        };
    }]);
