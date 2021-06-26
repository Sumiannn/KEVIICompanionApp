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
    var backButton = find.byValueKey('Back Button');

    test('Test Sign Up link', () async {
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(SignUpLink);
      await Future.delayed(Duration(seconds: 1));
      var SignUpText = find.text('Sign Up');
      await driver.waitUntilNoTransientCallbacks();
      assert(SignUpText != null);
    });

    test('Test Sign Up page empty fields', () async {
      var signUpButton = find.byValueKey('Sign Up Button');
      await driver.tap(signUpButton);
      var errorPrompt = find.text('Enter your NUS Email');
      assert(errorPrompt != null);
      await Future.delayed(Duration(seconds: 1));
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
    var news = find.text('#KEALUMNI');
    var newsImage = find.byValueKey('News panel');


    test('Test Home Page', () async {
      await driver.scrollUntilVisible(homeSlidingPanel, accountButton);
      await Future.delayed(Duration(seconds: 3));
      await driver.scrollUntilVisible(homeSlidingPanel, facilitesButton);
      await Future.delayed(Duration(seconds: 3));
      await driver.scrollUntilVisible(latestNewsPanel, news);
      await Future.delayed(Duration(seconds: 2));
    });

    test('Latest News Page', () async {
      await driver.tap(newsImage);
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 2));
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
      await driver.scroll(scrollable, 0.0, 300, Duration(seconds:1));
      await Future.delayed(Duration(seconds: 5));
      var stageOneButton = find.text('Federated Malay States Hostel');
      await driver.tap(stageOneButton);
      var historyPage = find.byValueKey('History Page');
      await driver.scroll(historyPage, 0.0, -300, Duration(seconds:1));
      await Future.delayed(Duration(seconds: 1));
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
    var laos = find.text('OCIP Laos');
    var keBand = find.text('KE Band');
    var xinyao = find.text('Xinyao');
    var handball = find.text('Handball');
    var ulti = find.text('Ultimate Frisbee');
    var tabBarView = find.byValueKey('tabBarView');

    test('Test Committee CCA', () async {
      await driver.tap(ccaInfoButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(committeeButton);
      await Future.delayed(Duration(seconds: 2));
      await driver.scrollUntilVisible(tabBar, laos);
      await driver.tap(laos);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:3));
      await driver.scrollUntilVisible(tabBar, yearbook);
      await driver.tap(yearbook);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:3));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 2));
    });

    test('Test Cultural CCA', () async {
      await driver.tap(culturalButton);
      await Future.delayed(Duration(seconds: 2));
      await driver.scrollUntilVisible(tabBar, keBand);
      await driver.tap(keBand);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:3));
      await driver.scrollUntilVisible(tabBar, xinyao);
      await driver.tap(xinyao);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:3));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 2));
    });

    test('Test Sports CCA', () async {
      await driver.tap(sportsButton);
      await Future.delayed(Duration(seconds: 2));
      await driver.scrollUntilVisible(tabBar, handball);
      await driver.tap(handball);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:3));
      await driver.scrollUntilVisible(tabBar, ulti);
      await driver.tap(ulti);
      await driver.scroll(tabBarView, 0.0, -200, Duration(seconds:3));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 1));
    });

    var addBooking = find.byValueKey('Add a booking option');
    var checkBooking = find.byValueKey('Check current bookings option');

    test('Add Booking', () async {
      await driver.tap(facilitesButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(addBooking);
      await Future.delayed(Duration(seconds: 1));
      var addButton = find.text('Add Booking');
      await driver.tap(addButton);
      await Future.delayed(Duration(seconds: 1));
      var ok = find.text('Ok');
      await driver.tap(ok);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 1));
    });

    test('Check Bookings', () async {
      await driver.tap(checkBooking);
      await Future.delayed(Duration(seconds: 1));
      var CommHall = find.text('Comm Hall');
      await driver.tap(CommHall);
      await Future.delayed(Duration(seconds: 1));
      var danceStudio = find.text('Dance Studio');
      await driver.scrollUntilVisible(tabBar, danceStudio);
      await driver.tap(danceStudio);
      await Future.delayed(Duration(seconds: 1));
      var diningHall = find.text('Dining Hall');
      await driver.scrollUntilVisible(tabBar, diningHall);
      await driver.tap(diningHall);
      await Future.delayed(Duration(seconds: 1));
      var panel = find.byValueKey('Panel');
      await driver.tap(panel);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(backButton);
      await Future.delayed(Duration(seconds: 2));

    });

    test('Account Page', () async{
      await driver.scrollUntilVisible(homeSlidingPanel, accountButton);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(accountButton);
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(backButton);
      var signOut = find.byValueKey('Sign out button');
      await driver.tap(signOut);
      await Future.delayed(Duration(seconds: 10));
    });
  });
}