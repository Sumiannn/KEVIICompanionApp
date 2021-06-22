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
    var textField = find.byType(TextField);
    expect(textField, findsNWidgets(2));

    // Test for Log In button
    var button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);

    // Test for Sign Up Link
    var SignUpLink = find.byType(GestureDetector);
    expect(SignUpLink, findsWidgets);
  });
}