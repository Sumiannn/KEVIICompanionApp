import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
void main() {
  group('KEVII Companion App Test', () {

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDownAll((){
      if(driver != null) {
        driver.close();
      }
    });

    var emailTextField = find.byValueKey('Email Field');
    var pwTextField = find.byValueKey('Password Field');
    var button = find.byType('ElevatedButton');
    var header = find.text('Welcome E0524717');
    var SignUpLink = find.byValueKey('Sign Up Link');

    test('Test Sign Up link', () async {
      await driver.tap(SignUpLink);
      await Future.delayed(Duration(seconds: 1));
      var SignUpText = find.text('Sign Up');
      await driver.waitUntilNoTransientCallbacks();
      assert(SignUpText != null);
      await Future.delayed(Duration(seconds: 3));
      var backButton = find.byValueKey('Back button');
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 1));
    });

    test('Test Sign in function', () async {

      await driver.tap(emailTextField);
      await Future.delayed(Duration(seconds: 1));
      await driver.enterText("E0524717@u.nus.edu");
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(pwTextField);
      await Future.delayed(Duration(seconds: 1));
      await driver.enterText("123456");
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(button);
      await Future.delayed(Duration(seconds: 1));
      await driver.waitFor(header);
      await driver.waitUntilNoTransientCallbacks();
      assert (header != null);
      await Future.delayed(Duration(seconds: 5));

    }, timeout: Timeout.none);

  });
}