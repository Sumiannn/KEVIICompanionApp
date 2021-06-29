import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:keviiapp/Latestnews/LatestNewsPage.dart';

String headline = 'Test Headline', subheading = 'Test Subheading', news = 'Test News',
imageURL = 'https://i.imgur.com/uMOywKH.jpg';

Widget makeTestableWidget() => new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: LatestNewsPage(headline, subheading, news, imageURL)));

void main() async {
    testWidgets('Facilities Options Page Widget Test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(makeTestableWidget()));

    var backButton = find.byKey(Key('Back Button'));
    expect(backButton, findsOneWidget);

    var homeButton = find.byKey(Key('Home Button'));
    expect(homeButton, findsOneWidget);

    var signOutButton = find.byKey(Key('Sign Out Button'));
    expect(signOutButton, findsOneWidget);

    var headline = find.byKey(Key('Title'));
    expect(headline, findsOneWidget);

    var subheading = find.byKey(Key('Subheading'));
    expect(subheading, findsOneWidget);

    var news = find.byKey(Key('News'));
    expect(news, findsOneWidget);

    });
}