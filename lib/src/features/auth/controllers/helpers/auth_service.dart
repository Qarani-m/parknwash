import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  final box = GetStorage();

  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  BuildContext? context = Get.context;

// -----------------------------------Register---------------------------------
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    String res = "Some Error Ocurred";

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(credential.user!.uid).set({
        "displayName": name,
        "email": email,
        "phoneNumber": phone,
        "uid": credential.user!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Map<String, dynamic> localData = {
    "displayName": name,
    "email": email,
    "phoneNumber": phone,
    "uid": credential.user!.uid,
    'createdAt': DateTime.now().toIso8601String(), // Use regular DateTime for local storage
  };

      saveUserData(localData);
      box.write('useId', credential.user!.uid);
      res = "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context!, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context!, "The account already exists for that email");
      }
    } catch (e) {
      // showSnackBar(context!, "An Unknown Error Occured: ${e}");
      Get.snackbar('Failure', "$e");
    }
    return res;
  }

  // ------------------Login___________________________________________

  Future<Map<String, dynamic>> signInOrRegisterWithGoogle() async {
    Map<String, dynamic> response = {
      "status": "error",
      "message": "An unknown error occurred",
      "isNewUser": false,
      "userData": null
    };

    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        response["message"] = "Sign in aborted by user";
        return response;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in (or register) to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is new or existing
      response["isNewUser"] =
          userCredential.additionalUserInfo?.isNewUser ?? false;

      final User? user = userCredential.user;

      if (user != null) {
        response["status"] = "success";
        response["message"] = response["isNewUser"]
            ? "New user registered"
            : "Existing user signed in";
        response["userData"] = {
          "uid": user.uid,
          "displayName": user.displayName ?? "",
          "email": user.email ?? "",
          "phoneNumber": user.phoneNumber ?? "",
          "photoURL": user.photoURL ?? "",
        };
      } else {
        response["message"] =
            "Failed to get user data after sign-in/registration";
      }
    } on FirebaseAuthException catch (e) {
      response["message"] = e.message ?? "FirebaseAuthException occurred";
      showSnackBar(context!, "FirebaseAuthException occurred 0");
    } on Exception catch (e) {
      showSnackBar(context!, "FirebaseAuthException occurred 1");
      response["message"] = "Exception occurred: $e";
    }
    return response;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String userId = result.user?.uid ?? '';

      if (userId.isNotEmpty) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          userData['user'] = result.user;
          DateTime createdAtDate = userData['createdAt'].toDate();
          int year = createdAtDate.year;
          String monthName = DateFormat('MMMM')
              .format(createdAtDate); // Gets full month name (e.g., June)

          Map<String, dynamic> userDataBox = {
            "displayName": userData['displayName'],
            "email": userData['email'],
            "phoneNumber": userData['phoneNumber'],
            "uid": userData['uid'],
            'createdAt': "${monthName}, ${year}",
          };
          AuthService().saveUserData(userDataBox);
          return result.user;
        } else {
          showSnackBar(context!, 'User data not found in Firestore.');
          return null;
        }
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context!, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context!, "Wrong password provided for that user.");
      } else {
        showSnackBar(context!, 'An unknown error occurred.');
      }
    }
    return null;
  }

// -----------------------------------Helpers-------------------------------------------------
  void showSnackBar(BuildContext context, String message) {
    final theme = Theme.of(context!);
    final isLightMode = theme.brightness == Brightness.light;
    final snackBar = SnackBar(
      backgroundColor:
          Colors.transparent, // Make the SnackBar's background transparent
      behavior: SnackBarBehavior.floating,
      elevation: 0, // Remove default elevation
      margin: EdgeInsets.all(16), // Margin for floating SnackBar
      content: Container(
        decoration: BoxDecoration(
          color: isLightMode ? Colors.white : Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          textAlign: TextAlign.center,
          message,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Color(0xFFDC143c)),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> createUserProfile(Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userData['uid'])
        .set({
      'displayName': userData['displayName'],
      'email': userData['email'],
      'phoneNumber': userData['phoneNumber'],
      'createdAt': FieldValue.serverTimestamp(),
      "uid": userData['uid']
    });
    saveUserData(userData);
  }

  void saveUserData(Map<String, dynamic> userData) {
    final box = GetStorage();
    String userJson = jsonEncode(userData);
    box.write('userData', userJson);
  }
}
