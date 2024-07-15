import 'package:cloud_firestore/cloud_firestore.dart';

class BookingData {
  final int eta;
  final String lotId;
  final String phone;
  final String status;
  final Timestamp timestamp;
  final String userId;
  final String vehicleRegNo;
  final String name;
  BookingData({
    required this.eta,
    required this.lotId,
    required this.phone,
    required this.status,
    required this.timestamp,
    required this.userId,
    required this.name,
    required this.vehicleRegNo,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      eta: json['eta'],
      lotId: json['lotId'],
      phone: json['phone'],
      status: json['status'],
      timestamp: json['timestamp'],
      userId: json['userId'],
      name: json['name'],
      vehicleRegNo: json['vehicleRegNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eta': eta,
      'lotId': lotId,
      'phone': phone,
      'status': status,
      'timestamp': timestamp,
      'userId': userId,
      'name': name,
      'vehicleRegNo': vehicleRegNo,
    };
  }
}
