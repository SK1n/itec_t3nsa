import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

class FirebaseController extends GetxController {
  late FirebaseAuth _firebaseAuth;

  Future<bool> isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      EasyLoading.show();
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
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
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user!.uid)
            .set({"email": user.user!.email});

        await signOut();

        return user;
      });
      EasyLoading.showSuccess(
          'Account created successfully for user ${userCredential.user!.email}.');

      Get.back();
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
    } catch (e) {
      EasyLoading.showError('Error occurred while creating account: $e');
    }
  }

  Future<void> signOut() async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.signOut();
      Get.toNamed(Routes.login);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError('Error signing out: $e');
    }
  }

  @override
  void onInit() {
    _firebaseAuth = FirebaseAuth.instance;
    super.onInit();
  }
}
