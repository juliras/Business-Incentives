
angular.module('businessIncentivesApp')
    .service('enterpriseZoneService', function () {

        var inEZ = false;
        var inEREZ = false;
        var adminZone = "N/A";

        // Determine if a feature includes the current marker
        var featureContainsMarker = function (myFeature, marker) {

            var inZone = false;
            var geometry = myFeature.getGeometry();
            var polygons = geometry.getArray();

            switch (geometry.getType()) {

                case "MultiPolygon":

                    polygons.forEach(function (poly, index) {
                        inZone |= this.geometryContainsMarker(poly.getArray(), marker);
                    });
                    break;
                default:
                    break;
            }

            return inZone;
        };

        // Returns wheather or not the marker
        // is located within the feature geometry
        var geometryContainsMarker = function (linearRings, marker) {

            for (var ring_index = 0; ring_index < linearRings.length; ring_index++) {
                var exterior_latlng = linearRings[0].getArray();
                var holes_latlng = [[null]];

                if (linearRings.length > 1) {
                    holes_latlng = linearRings.slice(1);
                }

                var poly = new google.maps.Polygon({ paths: exterior_latlng });

                if (google.maps.geometry.poly.containsLocation(marker.getPosition(), poly)) {

                    for (var hole_index = 0; hole_index < holes_latlng.length; hole_index++) {

                        hole = new google.maps.Polygon({ path: holes_latlng[hole_index].getArray() });

                        if (google.maps.geometry.poly.containsLocation(marker.getPosition(), hole)) {

                            return false;
                        }
                    }

                    return true;
                }
            }

            return false;
        };

        // Degug fxn
        var LogToConsole = function (value) {
            if (this._DEBUG_) {
                console.log(value);
            }
        };

        return {
            featureContainsMarker: featureContainsMarker,
            inEnterpriseZone: inEZ,
            inEnhancedRuralEZ: inEREZ,
            adminZone: adminZone
        };
    });