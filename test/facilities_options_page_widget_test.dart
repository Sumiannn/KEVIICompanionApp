import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keviiapp/Facilities/FacilitiesOptionScreen.dart';


void main() async {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: FacilitiesOptionsScreen()));
  testWidgets('Facilities Options Page Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    
    var backButton = find.byKey(Key('Back Button'));
    expect(backButton, findsOneWidget);
    
    var homeButton = find.byKey(Key('Home Button'));
    expect(homeButton, findsOneWidget);

    var signOutButton = find.byKey(Key('Sign Out Button'));
    expect(signOutButton, findsOneWidget);
  });
}