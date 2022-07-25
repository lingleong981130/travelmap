import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travelmap/facebook/loginPage.dart';
import 'package:travelmap/google/LoginScreen.dart';
import 'package:travelmap/page/forgot_pass.dart';
import 'package:travelmap/page/signup.dart';
import 'package:travelmap/phone/loginScreen.dart';
import 'package:travelmap/user.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  var email = " ";
  var password = " ";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password:password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain(title: 'Travel Map',)));

    }on FirebaseAuthException catch(error){
      if(error.code == 'user-note-found'){
        print('No user found for that email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('No user found for that email',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),),
        ),
        );
      }
      else if (error.code == 'wrong-password'){
        print('Wrong password provided by the user');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('Wrong password provided by the user',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),),
        ),
        );
      }
    }
  }


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: ListView(
            children: [
              Padding(padding:  const EdgeInsets.all(8.0),
                child: Image.asset("assests/login.jpg"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,
                      fontSize: 15,),
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter email';
                    }
                    else if (!value.contains('@')){
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,
                      fontSize: 15,),
                  ),
                  controller: passwordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState((){
                          email = emailController.text;
                          password = passwordController.text;
                        });
                        userLogin();
                      }
                    },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPass(),),);
                    },
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.all(0.0),
                          child: FlatButton(
                              child: Column(
                                children: [
                                  Image.asset("assests/google.png", width:130, height: 40,),
                                ],
                              ),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              }
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(0.0),
                          child: FlatButton(
                              child: Column(
                                children: [
                                  Image.asset("assests/fb.png", width:130,height: 50),
                                ],
                              ),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FbLoginPage()),
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(0.0),
                      child: FlatButton(
                          child: Column(
                            children: [
                              Image.asset("assests/phone.png", width:500,height: 40),
                            ],
                          ),
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PhoneLoginScreen()),
                            );
                          }
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Do not have an account ?'),
                          TextButton(onPressed: (){
                            Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=> Signup(), transitionDuration: Duration(seconds: 0)), (route)=> false);
                          },
                            child: Text('Signup'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
