import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmap/facebook/loginController.dart';
import 'package:travelmap/facebook/loginPage.dart';
import 'package:travelmap/google/LoginScreen.dart';
import 'package:travelmap/google/controllerLogin.dart';
import 'package:travelmap/page/login.dart';
import 'package:travelmap/restaurant/providers/info_window_provider.dart';
import 'package:travelmap/restaurant/providers/map_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp>_initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
        };
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (context) => ControllerLogin(),
            child: LoginScreen(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginController(),
            child: FbLoginPage(),
          ),
          ListenableProvider(create: (_) => MapProvider()),
          ListenableProvider(create: (_) => InfoWindowProvider()),

        ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Email & Password',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginPage(),
            ));
      },
    );
  }
}

