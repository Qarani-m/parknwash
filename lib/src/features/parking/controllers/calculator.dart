import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);

  @override
  String toString() {
    return 'GeoPoint(latitude: $latitude, longitude: $longitude)';
  }
}

class GeoBoundingBox {
  final GeoPoint northeast;
  final GeoPoint southwest;

  GeoBoundingBox(this.northeast, this.southwest);

  @override
  String toString() {
    return 'GeoBoundingBox(northeast: $northeast, southwest: $southwest)';
  }
}

class ManualCalculations {
  GeoBoundingBox getBoundingBox(GeoPoint center, double radiusInKm) {
    final double lat = center.latitude;
    final double lon = center.longitude;
    final double radiusInDegrees = radiusInKm / 111.32;

    final double minLat = lat - radiusInDegrees;
    final double maxLat = lat + radiusInDegrees;

    final double minLon = lon - radiusInDegrees / cos(lat * pi / 180);
    final double maxLon = lon + radiusInDegrees / cos(lat * pi / 180);

    return GeoBoundingBox(GeoPoint(maxLat, maxLon), GeoPoint(minLat, minLon));
  }

  double calculateDistance(GeoPoint point1, GeoPoint point2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((point2.latitude - point1.latitude) * p) / 2 +
        c(point1.latitude * p) *
            c(point2.latitude * p) *
            (1 - c((point2.longitude - point1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  Future<List<QueryDocumentSnapshot>> getLocationsNearMe(
      GeoPoint geoPoint) async {
    // Your current location
    GeoPoint center = geoPoint;
    double radiusInKm = 100;

    // Calculate bounding box
    GeoBoundingBox boundingBox = getBoundingBox(center, radiusInKm);

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('lots').get();

    List<QueryDocumentSnapshot> filteredDocs = querySnapshot.docs.where((doc) {
      GeoPoint coords =
          GeoPoint(doc['coords'].latitude, doc['coords'].longitude);
      return coords.latitude >= boundingBox.southwest.latitude &&
          coords.latitude <= boundingBox.northeast.latitude &&
          coords.longitude >= boundingBox.southwest.longitude &&
          coords.longitude <= boundingBox.northeast.longitude;
    }).toList();
    return filteredDocs;
  }

  Future<List<Map<String, dynamic>>> testes(double lat, double long) async {
    List<QueryDocumentSnapshot> nearbyLocations =
        await getLocationsNearMe(GeoPoint(lat, long));

    List<Map<String, dynamic>> lotDetails = [];

    for (var doc in nearbyLocations) {
      // Ensure doc.data() is not null
      var data = doc.data() as Map<String, dynamic>?;

      if (data != null) {
        var coords = data['coords'];
        if (coords != null) {
          double latitude = coords.latitude;
          double longitude = coords.longitude;
          String rates = data["rates"].toString();
          lotDetails.add({
            'id': doc.id.substring(0, 5).toUpperCase(),
            'position': {
              'latitude': latitude,
              'longitude': longitude,
            },
            "rates":rates
          });
        } else {}
      } else {}
    }
    // print('Locations found: ${lotDetails}');
    return lotDetails;
  }
}



class MapUtils {
  static double calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // in meters

    // Convert degrees to radians
    double lat1 = _degreesToRadians(start.latitude);
    double lon1 = _degreesToRadians(start.longitude);
    double lat2 = _degreesToRadians(end.latitude);
    double lon2 = _degreesToRadians(end.longitude);

    // Haversine formula
    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = earthRadius * c;

    return distance; // Returns distance in meters
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
