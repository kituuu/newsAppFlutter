import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../presentation/utils/showSnackBar.dart';



class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // State Persistence
  Stream<User?> get authState => _auth.authStateChanges();

  // Email register sign up function
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Email login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
}) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // if (!_auth.currentUser!.emailVerified) {
      //   await sendEmailVerification(context);
      // }
     print( _auth.currentUser);
    }on FirebaseAuthException catch(ex) {
      showSnackBar(context, ex.message!);

    }
  }

  // Google Sign in
  Future<void> signInWithGoogle({required BuildContext context}) async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);
      }
      // if (!_auth.currentUser!.emailVerified) {
      //   await sendEmailVerification(context);
      // }
    }on FirebaseAuthException catch(ex) {
      // showSnackBar(context, ex.message!);
      throw ex;

    }
  }

}
