import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travelmap/facebook/userModel.dart';



class LoginController with ChangeNotifier{
  UserDetails? userDetails;

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions:["public_profile", 'email'],);
    if(loginResult.status == LoginStatus.success){
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture.type(large)",
      );

      this.userDetails = new UserDetails(
        displayName: requestData["name"],
        email: requestData["email"],
        photoURL: requestData["picture"]["data"]["url"]?? " ",
      );

      notifyListeners();
    }

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

  }

  allowUserToSignInWithFB() async{

    var result = await FacebookAuth.i.login(
      permissions:["public_profile", 'email'],
    );

    if(result.status == LoginStatus.success){
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture.type(large)",
      );

      this.userDetails = new UserDetails(
          displayName: requestData["name"],
          email: requestData["email"],
          photoURL: requestData["picture"]["data"]["url"]?? " ",
      );

      notifyListeners();
    }
 }

  allowUserToSignOut() async{
    await FacebookAuth.i.logOut();
    userDetails = null;
    notifyListeners();
  }
}