import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelmap/google/userDetailsModel.dart';


class ControllerLogin with ChangeNotifier{
  var googleSignInNow = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  UserDetailsModel? userDetailsModel;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    this.googleSignInAccount = await googleSignInNow.signIn();
    this.userDetailsModel = new UserDetailsModel(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  allowUserToLogin() async{
    this.googleSignInAccount = await googleSignInNow.signIn();
    this.userDetailsModel = new UserDetailsModel(
        displayName: this.googleSignInAccount!.displayName,
        email: this.googleSignInAccount!.email,
        photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }

  allowUserToLogOut() async{
    this.googleSignInAccount = await googleSignInNow.signOut();

    userDetailsModel = null;
    notifyListeners();
  }


}