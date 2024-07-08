import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/profile/models/lot_model.dart';

class FavouritesController extends GetxController {
  RxList<dynamic> favourites = <dynamic>[].obs;
  RxList<Lot> favouriteLots = <Lot>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserFavourites("50AGMiEqHMWmiGDeiRrWEny63JB3");
  }

  Future<void> fetchUserFavourites(String userId) async {
    try {
      isLoading.value = true;
      final firestore = FirebaseFirestore.instance;
      final userDoc = firestore.collection('users').doc(userId);
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data.containsKey('favourites')) {
          final userFavourites = List<dynamic>.from(data['favourites']);
          favourites.value = userFavourites;
          print(favourites.value);
          await getLots();
          await    updateLotsWithAverageRatings();
        }
      }
    } catch (e) {
      print('Error fetching user favourites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getLots() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final lotsCollection = firestore.collection('lots');
      
      favouriteLots.clear();

      for (var lotId in favourites) {
        final lotDoc = await lotsCollection.doc(lotId).get();
        
        if (lotDoc.exists) {
          final lot = Lot.fromDocument(lotDoc);
          favouriteLots.add(lot);
        }
      }

      print('Retrieved ${favouriteLots.length} favourite lots');
    } catch (e) {
      print('Error retrieving favourite lots: $e');
    }
  }


  Future<double> getAverageRating(String lotId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final reviewsCollection = firestore.collection('reviews');
      
      // Query for reviews matching the lotId
      final querySnapshot = await reviewsCollection
          .where('lotId', isEqualTo: lotId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return 0.0; // Return 0 if no reviews found
      }

      // Calculate the sum of all ratings
      double totalRating = 0;
      for (var doc in querySnapshot.docs) {
        totalRating += (doc.data()['rating'] as num).toDouble();
      }

      // Calculate and return the average rating
      return totalRating / querySnapshot.docs.length;
    } catch (e) {
      print('Error calculating average rating: $e');
      return 0.0; // Return 0 in case of error
    }
  }

  Future<void> updateLotsWithAverageRatings() async {
    for (var lot in favouriteLots) {
      final averageRating = await getAverageRating(lot.id);
      lot.averageRating = averageRating;
    }
    // Trigger UI update
    favouriteLots.refresh();
  }
 

}