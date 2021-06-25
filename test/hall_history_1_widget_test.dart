import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keviiapp/HallInfo/Hall_History/HallHistoryPart1.dart';

import '../lib/HallInfo/Hall_History/HallHistory.dart';

void main() {

  testWidgets("Go to Hall History pages", (WidgetTester tester) async {
    // find all widgets needed

    await tester.pumpWidget(MaterialApp(home: HallHistoryPart1()));

    var title = find.text('Federated Malay States (F.M.S.) Hostel');
    expect(title, findsOneWidget);

    var subtitle = find.text('Sepoy Lines (1916-1956)');
    expect(subtitle, findsOneWidget);

    var backButton = find.byKey(Key('Back Button'));
    expect(backButton, findsOneWidget);

    var imageHall = find.byKey(Key('FMS Image'));
    expect(imageHall, findsOneWidget);

    var longText = find.byKey(Key('Long Text'));
    expect(longText, findsOneWidget);

  });

}