import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keviiapp/SignInSignUp/email_login.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: EmailLogIn()));
  testWidgets('Sign in page test', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    //Test for Image/ Logo
    var logo = find.byType(Image);
    expect(logo, findsOneWidget);

    //Test for Email and Password Fields
    var emailTextField = find.byKey(Key('Email Field'));
    expect(emailTextField, findsOneWidget);
    var pwTextField = find.byKey(Key('Password Field'));
    expect(pwTextField, findsOneWidget);

    // Test for Log In button
    var button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);

    // Test for Sign Up Link
    var SignUpLink = find.byKey(Key('Sign Up Link'));
    expect(SignUpLink, findsWidgets);
  });
}