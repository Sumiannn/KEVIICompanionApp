
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

    var header = find.byKey(Key('Facilities Header'));
    expect(header, findsOneWidget);

    var subheading = find.byKey(Key('Subheading'));
    expect(subheading, findsOneWidget);
    
    var manageMyBookings = find.byKey(Key('Manage my bookings option'));
    expect(manageMyBookings, findsOneWidget);

    var checkCurrentBookings = find.byKey(Key('Check current bookings option'));
    expect(checkCurrentBookings, findsOneWidget);

    var addBooking = find.byKey(Key('Add a booking option'));
    expect(addBooking, findsOneWidget);

  });
}