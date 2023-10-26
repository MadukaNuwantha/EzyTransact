// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezytransact/models/user_model.dart';
import 'package:ezytransact/widgets/snack_bars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  UserModel activeUser = UserModel();
  //   instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //   instance for firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // user registration
  Future<UserCredential?> registerUser(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    try {
      // register the user
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save the user in the database
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'name': name,
          'email': email,
        },
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('The password provided is too weak.'),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('The account already exists for that email.'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
    return null;
  }

  // user login
  Future<UserCredential?> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      //   sign in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('No user found for that email.'),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Wrong password provided for that user.'),
        );
      }
    }
    return null;
  }

  // user logout
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // get user details
  Future<void> getUserDetails(
    BuildContext context,
  ) async {
    try {
      final docRef = _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          activeUser = UserModel.fromJson(data);
          notifyListeners();
        },
      );
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('No user found for that email.'),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Wrong password provided for that user.'),
        );
      }
    }
  }
}
