import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService<T> {
  final String collection;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  FirestoreService({
    required this.collection,
    required this.fromJson,
    required this.toJson,
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<String> addDocument(T data) async {
    try {
      DocumentReference docRef = await _firestore.collection(collection).add(toJson(data));
      return docRef.id;
    } catch (e) {
      print('Error adding document: $e');
      rethrow;
    }
  }

  // Read
  Future<List<T>> getDocuments() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collection).get();
      return querySnapshot.docs.map((doc) => fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error getting documents: $e');
      rethrow;
    }
  }

  Future<T?> getDocument(String documentId) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection(collection).doc(documentId).get();
      if (docSnapshot.exists) {
        return fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting document: $e');
      rethrow;
    }
  }

  // Update
  Future<void> updateDocument(String documentId, T data) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(toJson(data));
    } catch (e) {
      print('Error updating document: $e');
      rethrow;
    }
  }

  // Delete
  Future<void> deleteDocument(String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      print('Error deleting document: $e');
      rethrow;
    }
  }

  // Stream of documents
  Stream<List<T>> streamDocuments() {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => fromJson(doc.data())).toList();
    });
  }
}