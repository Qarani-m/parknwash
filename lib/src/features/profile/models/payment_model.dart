import 'package:cloud_firestore/cloud_firestore.dart';

/// A model representing a payment.
class PaymentModel {
  final String uid;
  final String amount;
  final String lotId;
  final bool expired;
  final String referenceId;
  final DateTime createdAt;

  /// Creates a [PaymentModel] with the given parameters.
  ///
  /// [amount] - The amount of the payment.
  /// [lotId] - The ID of the lot associated with the payment.
  /// [expired] - Indicates whether the payment is expired.
  /// [referenceId] - The reference ID of the payment.
  /// [createdAt] - The date and time when the payment was created.
  PaymentModel({
    required this.uid,
    required this.amount,
    required this.lotId,
    required this.expired,
    required this.referenceId,
    required this.createdAt,
  });

  /// Creates a [PaymentModel] from a map (e.g., Firestore document).
  ///
  /// [map] - A map containing the payment data.
  ///
  /// Returns a [PaymentModel] instance populated with the data from the map.
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
