import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keviiapp/HomePage/home.dart';
import 'package:keviiapp/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  String uid = 'CO9uf8vrmXPcgDFchHJqh12q13J3';
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: Home()));
  testWidgets('Home Page Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    var homeButton = find.byIcon(Icons.home_rounded);
    expect(homeButton, findsOneWidget);
  });
}