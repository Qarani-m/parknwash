import 'package:cloud_firestore/cloud_firestore.dart';

/// A model representing a payment.
class PaymentModel {
  final String uid;
  final String amount;
  final String lotId;
  final bool expired;
  final String referenceId;
  final DateTime createdAt;

  PaymentModel({
    required this.uid,
    required this.amount,
    required this.lotId,
    required this.expired,
    required this.referenceId,
    required this.createdAt,
  });


  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      uid: map['uid'] ?? '',
      amount: map['amount'] ?? '',
      lotId: map['lotId'] ?? '',
      expired: map['expired'] ?? false,
      referenceId: map['referenceId'] ?? '',
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  /// Converts this [PaymentModel] instance to a map.
  ///
  /// Returns a map containing the payment data.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'amount': amount,
      'lotId': lotId,
      'expired': expired,
      'referenceId': referenceId,
      'createdAt': createdAt,
    };
  }
}
