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
      await Future.delayed(Duration(seconds: 1));
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

    test('Test invalid Log In details', () async {
      await driver.tap(button);
      await Future.delayed(Duration(seconds: 1));
      var emailValidation = find.text('Enter Email Address');
      assert(emailValidation != null);
      var pwValidation = find.text('Enter Password');
      assert(pwValidation != null);
      await Future.delayed(Duration(seconds: 3));

    }, timeout: Timeout.none);

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
    
    var homeSlidingPanel = find.byValueKey('Home sliding panel');
    var latestNewsPanel = find.byValueKey('Latest News Panel');
    var facilitesButton = find.byValueKey('Facilities Button');
    var accountButton = find.byValueKey('Account Info Button');
    var news = find.text('Just kidding LOL');
    var newsImage = find.byValueKey('News panel');


    test('Test Home Page', () async {
      await driver.scrollUntilVisible(homeSlidingPanel, accountButton);
      await Future.delayed(Duration(seconds: 3));
      await driver.scrollUntilVisible(homeSlidingPanel, facilitesButton);
      await Future.delayed(Duration(seconds: 3));
      await driver.scrollUntilVisible(latestNewsPanel, news);
      await driver.tap(newsImage);
      await Future.delayed(Duration(seconds: 2));
      var backButton = find.byValueKey('Back Button');
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 3));
    });

    var hallInfoButton = find.byValueKey('Hall Info Button');
    var hallHistoryButton = find.byValueKey('Hall History Button');
    var ccaInfoButton = find.byValueKey('CCA Info Button');


    test('Hall History', () async {

      await Future.delayed(Duration(seconds: 2));
      await driver.tap(hallInfoButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(hallHistoryButton);
      await Future.delayed(Duration(seconds: 2));
      var scrollable = find.byValueKey('Scrollable History');
      await driver.scroll(scrollable, 0.0, -300, Duration(seconds:1));
      await Future.delayed(Duration(seconds: 5));
      var stageOneButton = find.text('Federated Malay States Hostel');
      await driver.tap(stageOneButton);
      var historyPage = find.byValueKey('History Page');
      await driver.scroll(historyPage, 0.0, -300, Duration(seconds:1));
      await Future.delayed(Duration(seconds: 1));
      var backButton = find.byValueKey('Back Button');
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 3));
      var stageTwoButton = find.text('Holne Chase');
      await driver.tap(stageTwoButton);
      await driver.scroll(historyPage, 0.0, -300, Duration(seconds:1));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 3));

    });

    var committeeButton = find.byValueKey('Committee CCA Button');
    var culturalButton = find.byValueKey('Cultural CCA Button');
    var sportsButton = find.byValueKey('Sports CCA Button');
    var tabBar = find.byValueKey('Tab bar');
    var yearbook = find.text('Yearbook Committee');
    var tabBarView = find.byValueKey('tabBarView');

    test('Test CCA Info Page', () async {
      await driver.tap(ccaInfoButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(committeeButton);
      await Future.delayed(Duration(seconds: 2));
      await driver.scrollUntilVisible(tabBar, yearbook);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:1));
      await Future.delayed(Duration(seconds: 2));

    });
  });
}