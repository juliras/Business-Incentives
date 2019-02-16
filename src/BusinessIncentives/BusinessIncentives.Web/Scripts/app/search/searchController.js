(function () {
    var app = angular.module('businessIncentivesApp');
   
    app.controller('searchController', ['$scope', '$http', '$window', '$timeout', '$rootScope', '$document', '$uibModal', 'searchBusinessService', 'mappingService', 'enterpriseZoneService', 'referenceDataService', function ($scope, $http, $window, $timeout, $rootScope, $document, $uibModal, searchBusinessService, mappingService, enterpriseZoneService, referenceDataService) {

        $scope.initializeForm = initializeForm;
        $scope.hideMultiselectDropdowns = hideMultiselectDropdowns;
        $scope.generateMap = generateMap;
        $scope.initializeForm();

        // Business Type
        $scope.onBusinessTypeSelected = function (type) {
            $scope.businessInfo.businessType = type
            $scope.formFillingStarted = true;
        };

        // Industries
        $scope.onIndustrySelected = function (item) {
            $scope.industriesSelected = true;
        };
        $scope.getIndustryById = function (id) {
            return _.find($scope.formData.industries, function (industry) {
                return industry.id === id;
            });
        };
        
        // Business Name
        $scope.getBusinessNames = searchBusinessService.getBusinessNames;
        $scope.onBusinessNameSelected = function ($item, $model, $label, $event) {
            // An existing business has been selected... Let's use it to prepopulate the address
            var businessName = $model;

            searchBusinessService.getBusiness(businessName)
                .then(function (business) {

                    if (business) {
                        $scope.businessFound = true;
                        $scope.businessInfo.entityId = business.EntityId;
                        $scope.businessInfo.entityType = business.EntityType;
                        $scope.businessInfo.address.line1 = business.PrincipalAddress1;
                        $scope.businessInfo.address.line2 = business.PrincipalAddress2;
                        $scope.businessInfo.address.city = business.PrincipalCity;
                        $scope.businessInfo.address.state = business.PrincipalState;
                        $scope.businessInfo.address.zip = business.PrincipalZipCode;
                        $scope.addressFound = true;
                        if ($scope.mapWasLoadedOnce) {
                            generateMap();
                        }
                    }
                    else {
                        $scope.addressFound = false;
                    }
                    $scope.areBusinessNamesLoading = false;;
                    $scope.businessNameEntered = true;
                    $scope.formCompleted = true; // Temporary...
                });
        };
        $scope.onBusinessNameKeyUp = function ($event) {
            if ($event.key === "Tab" || $event.key === "Enter") {
                return true;
            }
            $scope.areBusinessNamesLoading = true;
        };
        $scope.onBusinessNameControlBlur = function () {
            $scope.businessNameEntered = true;
        };

        // Address
        $scope.onZipBlur = function () {
            $scope.formCompleted = true;
        };

        // Assistance Needed
        $scope.onAssistanceSelected = function (item) {
            $scope.assistancesSelected = true;
            $scope.formFillingStarted = true;
        };
        $scope.getAssistanceById = function (id) {
            return _.find($scope.formData.assistanceTypes, function (assistanceType) {
                return assistanceType.id === id;
            });
        };

        // Business Attributes
        $scope.onAttributeSelected = function (item) {
            $scope.attributesSelected = true;
        };
        $scope.getAttributeById = function (id) {
            return _.find($scope.formData.businessAttributes, function (attribute) {
                return attribute.id === id;
            });
        };

        $scope.search = function () {

            $scope.isLoading = true;

            $scope.searchModel.AssistanceTypesNames =
                _.map($scope.businessInfo.assistancesNeeded, function (assistanceNeeded) {
                    return $scope.getAssistanceById(assistanceNeeded.id).label;
                });

            $scope.searchModel.City = $scope.businessInfo.address.city;
            $scope.searchModel.State = $scope.businessInfo.address.state;
            $scope.searchModel.ZipCode = $scope.businessInfo.address.zip;

            generateMap();

            var promise = $http({
                method: "POST",
                url: "/api/search/assistance",
                data: $scope.searchModel,
                dataType: 'json',
                headers: { "Content-Type": "application/json" }
            });

            promise.then(function (result, status) {
                $scope.isResultVisible = true;
                $scope.isLoading = false;
                $scope.assistanceResult = result.data;
            });

            promise['catch'](function (result, status) {
                $window.alert(result.statusText);
            });
        };

        function generateMap() {
            $scope.isMapLoaded = false;
            if ($scope.businessInfo.address.city || $scope.businessInfo.address.zip) {
                $scope.isMapLoading = true;
                var address = $scope.businessInfo.address.line1 + ' ' + $scope.businessInfo.address.line2 + ' ' + $scope.businessInfo.address.city + ' ' + $scope.businessInfo.address.state + ' ' + $scope.businessInfo.address.zip;
                mappingService.generateMap(address, angular.element("#map")[0]).then(function () {
                    $scope.isMapLoading = false;
                    $scope.isMapLoaded = true;
                    $scope.mapWasLoadedOnce = true;
                });
            }
        }

        function initializeForm() {
            $scope.searchModel = {};
            $scope.searchModel.AssistanceTypesNames = [];
            $scope.formData = getFormData();
            $scope.addressFound = false;
            $scope.industriesSelected = false;
            $scope.businessNameEntered = false;
            $scope.formCompleted = false; 
            $scope.isResultVisible = false;
            $scope.opportunities = null;
            $scope.isMapLoaded = false;
            $scope.styles = mappingService.styles;
            $scope.mapWasLoadedOnce = false;

            $scope.formSettings =
            {
                enableSearch: true,
                scrollable: true,
                scrollableHeight: '350px',
                keyboardControls: 'true'
            };

            $scope.businessInfo = {
                entityId: null,
                entityType: null,
                businessType: null,
                name: null,
                industries: [],
                address: {
                    line1: null,
                    line2: null,
                    city: null,
                    state: null,
                    zip: null
                },
                assistancesNeeded: [],
                attributes: []
            };

            $scope.formFillingStarted = false;

            // General Keyboard Navigation
            $document.on('keyup', keyupHandler);
            function keyupHandler(keyEvent) {
                // Close the multiselect dropdown on Tab
                if (keyEvent.key === "Tab") {
                    hideMultiselectDropdowns();
                }
            }
        }

        function getFormData() {
            return {
                businessTypes: referenceDataService.businessTypes,
                industries: referenceDataService.industries,
                assistanceTypes: referenceDataService.assistanceTypes,
                businessAttributes: referenceDataService.businessAttributes
            };
        }

        // Reset Form Modal
        $scope.openConfirmModal = openConfirmModal;
        $rootScope.$on("initForm", function () {
            $scope.initializeForm();
        });

        function openConfirmModal(size, parentSelector) {
            var parentElem = parentSelector ?
                angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) : undefined;
            var modalInstance = $uibModal.open({
                animation: true,
                ariaLabelledBy: 'modal-title',
                ariaDescribedBy: 'modal-body',
                templateUrl: 'myModalContent.html',
                controller: 'confirmResetFormController',
                size: size,
                appendTo: parentElem,
                resolve: null
            });
        }

        // Hide multiselect dropdowns
        function hideMultiselectDropdowns() {
            angular.element("div[ng-dropdown-multiselect]>div").removeClass("open");
            angular.element("div[ng-dropdown-multiselect] ul").remove();
        }
    }]);

    app.controller('confirmResetFormController', ['$scope', '$uibModalInstance', '$rootScope', function ($scope, $uibModalInstance, $rootScope) {

        $scope.okResetForm = function (callBack) {
            $rootScope.$broadcast("initForm");
            $uibModalInstance.close();
        };

        $scope.cancelResetForm = function () {
            $uibModalInstance.close();
        };
    }]);


})();

