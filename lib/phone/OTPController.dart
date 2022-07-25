import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:travelmap/phone/homeScreen.dart';
import 'package:travelmap/user.dart';

class OTPControllerScreen extends StatefulWidget {
  final String phone;
  final String codeDigits;

  OTPControllerScreen({required this.phone, required this.codeDigits});

  @override
  _OTPControllerScreenState createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen>{

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.grey,
    )
  );

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigits + widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async{
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
          if(value.user!=null){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>HomeScreen(),),);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
        ),
        );
      },
      codeSent: (String vID, int? resendToken){
        setState((){
          verificationCode = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID){
        setState((){
          verificationCode = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffolkey,
        appBar: AppBar(
          title: Text('OTP Verification'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:Image.asset("assests/otp.png"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    verifyPhoneNumber();
                  },
                  child: Text("Verifying : ${widget.codeDigits}-${widget.phone}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                focusNode: _pinOTPCodeFocus,
                controller: _pinOTPCodeController,
                submittedFieldDecoration: pinOTPCodeDecoration,
                selectedFieldDecoration: pinOTPCodeDecoration,
                followingFieldDecoration: pinOTPCodeDecoration,
                pinAnimationType: PinAnimationType.rotation,
                onSubmit: (pin) async{
                  try{
                    await FirebaseAuth.
                    instance.signInWithCredential(PhoneAuthProvider.
                    credential(verificationId: verificationCode!, smsCode: pin)).then((value){
                      if(value.user!=null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>const UserMain(title: 'Travel Map',),),);
                      }
                    });
                  }
                  catch(e){
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid OTP",),
                        duration: Duration(seconds: 3),
                    ),);
                  }
                },
              )

            )
          ],
        )
    );
  }
}
