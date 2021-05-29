import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Screens/email_login.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Screens/home.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KEVII Community',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        navigateAfterSeconds: result != null ? Home(uid: result.uid) : EmailLogIn(),
        seconds: 5,
        image: new Image.asset('assets/image/KE2.jpg', fit: BoxFit.cover,),
        backgroundColor: Color(0xFF820312),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.amber);
  }
}