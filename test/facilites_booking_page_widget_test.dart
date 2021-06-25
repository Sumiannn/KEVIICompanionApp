import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keviiapp/Facilities/FacilitiesBookingPage.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

const MessagesCollection = 'messages';

void main() async {
  testWidgets('Facilities Options Page Widget Test', (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection(MessagesCollection).add({
      'message': 'Hello world!',
      'created_at': FieldValue.serverTimestamp(),
    });
    await tester.pumpWidget(MaterialApp(
        title: 'Firestore Example', home: FacilitiesBookingPage(firestore: firestore)));
    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();
    // // Verify the output.
    expect(find.text('Hello world!'), findsOneWidget);
    expect(find.text('Message 1 of 1'), findsOneWidget);

    var coverImage = find.byKey(Key('Cover Image'));
    expect(coverImage, findsOneWidget);
  });
}