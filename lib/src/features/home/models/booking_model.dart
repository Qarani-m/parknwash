import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingData {
  final int eta;
  final String lotId;
  final String phone;
  final String status;
  final Map<String, String> timestamp;
  final String userId;
  final String vehicleRegNo;
  final String name;
  final String realName;
  final Map<String, String> timeDifference;

  BookingData( 
      {
        required this.timeDifference,
        required this.eta,
      required this.lotId,
      required this.phone,
      required this.status,
      required this.timestamp,
      required this.userId,
      required this.vehicleRegNo,
      required this.name,
      required this.realName});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      timeDifference:json['timeDifference'],
      
        eta: json['eta'],
        lotId: json['lotId'],
        phone: json['phone'],
        status: json['status'],
        timestamp: json['timestamp'],
        userId: json['userId'],
        vehicleRegNo: json['vehicleRegNo'],
        name: json['name'],
        realName: json['realName']);
  }

  Map<String, dynamic> toJson() {
    return {
      "timeDifference":timeDifference,
      'eta': eta,
      'lotId': lotId,
      'phone': phone,
      'status': status,
      'timestamp': timestamp,
      'userId': userId,
      'name': name,
      'vehicleRegNo': vehicleRegNo,
      'realName': realName
    };
  }
}
