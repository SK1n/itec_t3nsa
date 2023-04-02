import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

class FirebaseController extends GetxController {
  isSignedIn() => FirebaseAuth.instance.currentUser != null;

  Future<String?> uploadImageFromUrlToFirebaseStorage(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw response;
      }
      final fileName = imageUrl.split('/').last;
      final storageRef = FirebaseStorage.instance
          .ref(FirebaseAuth.instance.currentUser!.uid)
          .child(fileName);
      final uploadTask = storageRef.putData(response.bodyBytes);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on Exception {
      rethrow;
    }
  }

  Future<List<String>> getArrayFromFirestore() async {
    EasyLoading.show();

    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final data = docSnapshot.data();
      final dynamic arrayData = data!['generatedImages'];
      EasyLoading.dismiss();
      return List<String>.from(arrayData);
    } on Exception catch (e) {
      EasyLoading.showError("Sorry we couldn't load the images");
      return [];
    }
  }

  Future<void> uploadDataToFirestore(String image) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference document = collection.doc(user.uid);
      await document.update({
        'generatedImages': FieldValue.arrayUnion([image])
      });
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.showSuccess("Successfully logged in.");
      Get.toNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showError('User not found.');
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError('Wrong password.');
      } else if (e.code == 'invalid-email') {
        EasyLoading.showError('Invalid email address.');
      } else if (e.code == 'user-disabled') {
        EasyLoading.showError('User account has been disabled.');
      } else {
        EasyLoading.showError('Error occurred while signing in: ${e.code}');
      }
    } catch (e) {
      EasyLoading.showError('Error occurred while signing in: $e');
    }
  }

  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      EasyLoading.show();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint(userCredential.user!.uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'createdAt': DateTime.now(),
        'generatedImages': [],
      });

      await signOut();
      EasyLoading.showSuccess('Account created successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        EasyLoading.showError(
            'The email address is already in use by another account.');
      } else if (e.code == 'invalid-email') {
        EasyLoading.showError('The email address is invalid.');
      } else if (e.code == 'weak-password') {
        EasyLoading.showError('The password is too weak.');
      } else {
        EasyLoading.showError(
            'Error occurred while creating account: ${e.code}');
      }
    } on Exception catch (e) {
      EasyLoading.showError('Error occurred while creating account: $e');
    }
  }

  Future<void> signOut() async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.signOut();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError('Error signing out: $e');
    }
  }
}
