import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

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

  Future<List<QueryDocumentSnapshot>> getLocationsNearMe() async {
    // Your current location
    GeoPoint center = GeoPoint(-0.3199485, 37.6492764);
    double radiusInKm = 100;

    // Calculate bounding box
    GeoBoundingBox boundingBox = getBoundingBox(center, radiusInKm);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lots')
        .get();

    List<QueryDocumentSnapshot> filteredDocs = querySnapshot.docs.where((doc) {
      GeoPoint coords = GeoPoint(doc['coords'].latitude, doc['coords'].longitude);
      return coords.latitude >= boundingBox.southwest.latitude &&
          coords.latitude <= boundingBox.northeast.latitude &&
          coords.longitude >= boundingBox.southwest.longitude &&
          coords.longitude <= boundingBox.northeast.longitude;
    }).toList();

    for (QueryDocumentSnapshot doc in filteredDocs) {
      print("----------------------------------");
      print("Document ID: ${doc.id}");
      print("Data: ${doc.data()}");
      print("----------------------------------");
    }

    return filteredDocs;
  }

  // Usage
  Future testes() async {
    List<QueryDocumentSnapshot> nearbyLocations = await getLocationsNearMe();
    for (var doc in nearbyLocations) {
      print('Location found: ${doc.id}');
    }

    print('Locations found: ${nearbyLocations.length}');
  }
}
