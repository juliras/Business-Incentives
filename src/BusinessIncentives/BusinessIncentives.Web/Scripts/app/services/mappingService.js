
angular.module('businessIncentivesApp')
    .service('mappingService', ['$q', function ($q) {

        var _DEBUG_ = false;
        var styleEZ = {
            fillColor: 'rgba(0,0,255,0.25)',
            fillOpacity: 1.0,
            strokeColor: 'darkgrey',
            strokeOpacity: 1.0,
            strokeWeight: 1,
            visible: true
        };
        var styleEZOZ = {
            fillColor: 'rgb(214, 194, 118)',
            fillOpacity: 0.62,
            strokeColor: 'darkgrey',
            strokeOpacity: 1.0,
            strokeWeight: 1,
            visible: true
        };
        var styleOZ = {
            fillColor: 'rgba(255,215,0,0.5)',
            fillOpacity: 1.0,
            strokeColor: 'darkslategrey',
            strokeOpacity: 1.0,
            strokeWeight: 1,
            visible: true
        };

        var map = null;
        var marker = null;

        // Inserts KML data into a visible layer
        // on the map and returns the new layer
        var addKML = function (map, src) {
            var kmlLayer = new google.maps.KmlLayer(src);
            kmlLayer.setMap(map);

            return kmlLayer;
        };

        // Map initialization routine
        var generateMap = function (addressString, mapHtmlElement) {

            
            var deferred = $q.defer(); 

            // Use Google Geocoder API to translate
            // an address to GPS coordinates
            var geocoder = new google.maps.Geocoder();
            var coordinates = {};

            geocoder.geocode({ address: addressString }, function (array, status) {
                if (status === 'OK') {
                    coordinates = array[0].geometry.location;

                    if (map) {
                        if (coordinates) {
                            marker = createMarker(map, coordinates);
                        }

                        deferred.resolve(); // resolve promise
                    }
                    else {
                        map = new google.maps.Map(mapHtmlElement, {
                            zoom: 7,
                            center: coordinates,
                            gestureHandling: 'cooperative'
                        });

                        // Create Data Layer for EZs
                        var dataLayerEZ = new google.maps.Data({ map: map, style: styleEZ });

                        // Create Data Layer for OZs
                        var dataLayerOZ = new google.maps.Data({ map: map, style: styleOZ });

                        // 1st) Add Enterprise Zone (EZ) data to visible layer
                        dataLayerEZ.loadGeoJson('https://data.colorado.gov/api/geospatial/k6js-8yuk?method=export&format=GeoJSON', null, function () {

                            // 2nd) Add Opportunity Zone (OZ) data to visible layer
                            dataLayerOZ.loadGeoJson('https://gocodecolorado.github.io/BusinessIncentives/certoppzones.geojson', null, function () {

                                // 3rd) Add Legend to map
                                map.controls[google.maps.ControlPosition.TOP_RIGHT].push(angular.element("#legend")[0]);

                                if (coordinates) {
                                    marker = createMarker(map, coordinates);
                                }
                                
                                deferred.resolve(); // resolve promise
                            });
                        });
                    }
                }
            });

            return deferred.promise;
        };

        // Add a marker to the map by searching
        // for named places in google
        var createMarker = function (map, coords) {

            centerMapAt(map, coords);
            setMapZoom(map, 13);

            return new google.maps.Marker({
                position: coords,
                map: map
            });
        };

        // Move the center of the map
        var centerMapAt = function (map, coords) {
            map.setCenter(coords);
        };

        // Set map zoom
        var setMapZoom = function (map, zoom) {
            map.setZoom(zoom);
        };

        // Degug fxn
        var LogToConsole = function (value) {
            if (_DEBUG_) {
                console.log(value);
            }
        };

        return {
            generateMap: generateMap,
            map: map,
            styles: {
                styleEZ: styleEZ,
                styleEZOZ: styleEZOZ,
                styleOZ: styleOZ
            }
        };
    }]);