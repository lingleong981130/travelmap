import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmap/facebook/loginController.dart';
import 'package:travelmap/page/fbuser.dart';

class FbLoginPage extends StatefulWidget{
  const FbLoginPage({Key? key}) : super(key: key);
  @override
  _FbLoginPageState createState() => _FbLoginPageState();
}

class _FbLoginPageState extends State<FbLoginPage>{

  loginPageUI(){
    return Consumer<LoginController>(builder:(context, model, child){
      if(model.userDetails != null){
        return const Center(
          child: FbUserMain(),
        );
      }
      else{
        return notLoggedInScreen();
      }
    });
  }

  alreadyLoggedInScreen(LoginController model)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
        backgroundImage: Image.network(model.userDetails!.photoURL ?? "").image,
          radius: 100,
        ),
        SizedBox(width: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            SizedBox(width: 20,),
            Text(
              model.userDetails!.displayName ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ],
        ),

        SizedBox(width: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 20,),
            Text(
              model.userDetails!.email ?? "",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 20,),

        ActionChip(
          backgroundColor: Colors.red,
          avatar: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Icon(Icons.logout, color:  Colors.white,),
          ),
          label: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          onPressed: () {
            Provider.of<LoginController>(context, listen: false).allowUserToSignOut();
          },
        ),
      ],
    );
  }

  notLoggedInScreen(){
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child:Image.asset("assests/facebook.png"),
          ),
          GestureDetector(
            child: Image.asset(
              "assests/fb.png", width: 240,
            ),
            onTap: (){
              Provider.of<LoginController>(context, listen: false).signInWithFacebook();
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black12,
      body: loginPageUI(),
    );
  }
}