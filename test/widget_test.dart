// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correte.dart';
import 'dart:io';

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit/auth.dart';
import 'package:habit/db.dart';
import 'package:habit/main.dart';
import 'package:habit/models.dart';
import 'package:habit/pages/habits/habit-card.dart';
import 'package:habit/pages/habits/habits-list.dart';
import 'package:habit/pages/habits/habits.dart';
import 'package:mockito/mockito.dart';

class AuthServiceMock extends Mock implements AuthService {}

class FirebaseUserMock extends Mock implements FirebaseUser {
  @override
  String get uid => 'azQGM1JCeBVoLFpFPr1C68wv1x73';
}

void main() async {
  final FirebaseUserMock user = FirebaseUserMock();

  Future<DatabaseService> getDatabaseService(FirebaseUserMock user) async {
    // Populate the mock database.
    final firestore = MockFirestoreInstance();
    await firestore.collection('habits').document(user.uid).setData({
      'habits': [
        'Wake up before 9:00',
        'Study for two hours',
      ],
    });

    var databaseService = DatabaseService();
    databaseService.db = firestore;

    return databaseService;
  }

  Future<HabitsPage> getHabitsPage(FirebaseUserMock user) async {
    var databaseService = await getDatabaseService(user);

    return HabitsPage(
      user: user,
      databaseService: databaseService,
    );
  }

  group('Habit create test group', () {
    // Widget will be nested inside. It's needed so that scaffold would be accessible
    Widget makeTestableWidget({Widget child}) {
      return MaterialApp(
        home: child,
      );
    }

/*    testWidgets('Read habit smoke test', (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Wake up before 9:00'), findsOneWidget);
      expect(find.text('Study for two hours'), findsOneWidget);
    });*/

    testWidgets('Add habit smoke test', (WidgetTester tester) async {
//      var databaseService = await getDatabaseService(user);

      /* var habitsPage = HabitsPage(
        user: user,
        databaseService: databaseService,
      );*/

      var habitsPage = await getHabitsPage(user);

      habitsPage.databaseService.streamHabits(user.uid).listen((d) => stderr.writeln('habits change'));
      // databaseService.streamHabits('123').listen((d) => stderr.writeln('change 2nd'));

      await tester.pumpWidget(makeTestableWidget(child: habitsPage));

      // Build Habit app and trigger a frame.
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));
      expect(find.text('ALL HABITS'), findsOneWidget);

      // See action button
      var addButton = find.byType(FloatingActionButton);
      expect(addButton, findsOneWidget);

      // Press action button
      await tester.tap(addButton);
      await tester.pump();

      // See Dialog
      expect(find.text('Create new habit'), findsOneWidget);

      // See input
      var input = find.byType(TextField);
      expect(input, findsOneWidget);

      // Enter text to input
      await tester.enterText(input, 'Some new testing habit name');

      // Submit the form
      var submitButton = find.text('Save');
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);


/*      var mock = habitsPage.databaseService.db as MockFirestoreInstance;

      mock.collection('habits')
          .document(user.uid)
          .setData({
        'habits': ['test', 'uopa'],
      });

      stderr.writeln(mock.dump());*/

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Some new testing habit name'), findsOneWidget);
    });

/*    testWidgets('Read habbit smoke test', (WidgetTester tester) async {
      var habitsPage = await getHabitsPage(user);
      await tester.pumpWidget(MyApp());
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));
      expect(find.text('ALL HABITS'), findsOneWidget);

      //expect(find.text('Some new testing habit name'), findsOneWidget);
      stderr.writeln('start new');
    });*/
  });
}
