import 'package:cloud_firestore/cloud_firestore.dart';

class Lot {
  final String id;
  final String locality;
  final String name;
  final double rates;
  final GeoPoint coords;
  double averageRating;

  Lot({
    required this.id,
    required this.locality,
    required this.name,
    required this.rates,
    required this.coords,
    this.averageRating = 0.0,
  });

  // Factory method to create a Lot instance from Firestore document data
  factory Lot.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Lot(
      id: doc.id,
      locality: data['locality'] as String? ?? '',
      name: data['name'] as String? ?? '',
      rates: _parseRates(data['rates']),
      coords: _parseGeoPoint(data['coords']),
    );
  }


  // Helper method to parse rates
  static double _parseRates(dynamic ratesData) {
    if (ratesData is num) {
      return ratesData.toDouble();
    } else if (ratesData is String) {
      return double.tryParse(ratesData) ?? 0.0;
    }
    return 0.0;
  }

  // Helper method to parse GeoPoint
  static GeoPoint _parseGeoPoint(dynamic coordsData) {
    if (coordsData is GeoPoint) {
      return coordsData;
    } else if (coordsData is Map<String, dynamic>) {
      final lat = coordsData['latitude'] as double?;
      final lng = coordsData['longitude'] as double?;
      if (lat != null && lng != null) {
        return GeoPoint(lat, lng);
      }
    }
    return GeoPoint(0, 0);
  }

  @override
  String toString() {
    return 'Lot(id: $id, locality: $locality, name: $name, rates: $rates, coords: $coords)';
  }
}