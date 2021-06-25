import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/HallInfo/Hall_History/HallHistory.dart';

void main() {

  testWidgets("Go to Hall History pages", (WidgetTester tester) async {
    // find all widgets neede

    // execute the actual test
    await tester.pumpWidget(MaterialApp(home: HallHistory()));

    var title = find.text('Hall History');
    expect(title, findsOneWidget);

    var subtitle = find.text('History of King Edward VII Hall');
    expect(subtitle, findsOneWidget);

    var backButton = find.byKey(Key('Back Button'));
    expect(backButton, findsOneWidget);

    var homeButton = find.byIcon(Icons.home_rounded);
    expect(homeButton, findsOneWidget);

    var logoutButton = find.byIcon(Icons.exit_to_app_rounded);
    expect(logoutButton, findsOneWidget);

    var firstStage = find.byKey(Key('first stage'));
    expect(firstStage, findsOneWidget);

    var secondStage = find.byKey(Key('second stage'));
    expect(secondStage, findsOneWidget);

    var thirdStage = find.byKey(Key('third stage'));
    expect(thirdStage, findsOneWidget);

    var fourthStage = find.text('1A Kent Ridge Road (1987-Present)');
    await tester.scrollUntilVisible(fourthStage, 300);
    expect(fourthStage, findsOneWidget);

  });

}
