(function () {
    'use strict';

    angular.module('businessIncentivesApp')
        .config(config);

    config.$inject = ['$routeProvider'];

    function config($routeProvider, $locationProvider) {

        $routeProvider
            .when("/", {
                templateUrl: Utils.baseUrl + "Scripts/app/home/homeView.html",
                controller: "homeController"
            })
            .when("/search", {
                templateUrl: Utils.baseUrl + "Scripts/app/search/searchView.html",
                controller: "searchController"
            })
            .when("/about", {
                templateUrl: Utils.baseUrl + "Scripts/app/about/aboutView.html",
                controller: "aboutController"
            })
            .when("/contact", {
                templateUrl: Utils.baseUrl + "Scripts/app/contact/contactView.html",
                controller: "contactController"
            })
            .when("/tos", {
                templateUrl: Utils.baseUrl + "Scripts/app/shared/legal/tosView.html",
                controller: "tosController"
            })
            .when("/privacyPolicy", {
                templateUrl: Utils.baseUrl + "Scripts/app/shared/legal/privacyPolicyView.html",
                controller: "privacyPolicyController"
            })
            .when("/submitOpportunity", {
                templateUrl: Utils.baseUrl + "Scripts/app/submitOpportunity/submitOpportunityView.html",
                controller: "submitOpportunityController"
            })
            .otherwise({ redirectTo: "/" });
    }
})();