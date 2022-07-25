import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travelmap/google/controllerLogin.dart';
import 'package:travelmap/page/gouser.dart';


final GoogleSignIn gSignIn = GoogleSignIn();


class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  loginUIController(){
    return Consumer<ControllerLogin>(
      builder: (context, model, child){
        //if user already loggedIn
        if(model.userDetailsModel != null){
          return Center(
            //show user details
            child: GoUserMain(),
          );
        }
        //if user Not loggedIn
        else{
          //show NotLoggedIn Screen
          return notLoggedInScreen();
        }
      },
    );
  }


  notLoggedInScreen(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image.asset("assests/googleback.jpg"),
          ),
          GestureDetector(
            onTap:(){
              Provider.of<ControllerLogin>(context, listen: false).signInWithGoogle();
            },
            child: Image.asset("assests/google.png", width:250,),
          ),
        ],
      ),
    );
  }


  alreadyLoggedInScreen(ControllerLogin model){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(model.userDetailsModel!.photoURL ?? "").image,
          radius: 100,
        ),
        SizedBox(height:20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person,
            color: Colors.black,),
            SizedBox(height: 20,),
            Text(
                model.userDetailsModel!.displayName ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),

        SizedBox(height:20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person,
              color: Colors.black,),
            SizedBox(height: 20,),
            Text(
              model.userDetailsModel!.displayName ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),

        SizedBox(height:20,),

        ActionChip(
          backgroundColor: Colors.black,
          avatar: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Icon(
              Icons.logout, color: Colors.white,),
          ),
          label: Padding(
            padding: EdgeInsets.only(left:15.0, right: 15.0),
            child: Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          onPressed: (){
            Provider.of<ControllerLogin>(context, listen: false).allowUserToLogOut();
          },
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: loginUIController(),
    );
  }
}