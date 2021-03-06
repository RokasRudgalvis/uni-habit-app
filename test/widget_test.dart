// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correte.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit/auth.dart';
import 'package:habit/db.dart';
import 'package:habit/fonts/emotion_icons.dart';
import 'package:habit/main.dart';
import 'package:habit/models.dart';
import 'package:habit/pages/habits/habit-card.dart';
import 'package:habit/pages/habits/habits-list.dart';
import 'package:habit/pages/habits/habits.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

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

    // Add habits
    await firestore.collection('habits').document(user.uid).setData({
      'habits': [
        'Wake up before 9:00',
        'Study for two hours',
      ],
    });

    // Add archived days
    await firestore
        .collection('dailyLog')
        .document(user.uid)
        .collection('days')
        .add({
      'complete': [
        'Wake up before 9:00',
      ],
      'date': DateTime.now(),
      'mood': 4
    });

    // Add points
    await firestore
        .collection('points')
        .document(user.uid)
        .setData({'points': 10});

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

  group('Habit CRUD test group', () {
    // Widget will be nested inside. It's needed so that scaffold would be accessible
    Widget makeTestableWidget({Widget child}) {
      return MaterialApp(
        home: child,
      );
    }

    testWidgets('1. Read habit smoke test', (WidgetTester tester) async {
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
    });

    testWidgets('2.1 Add habit smoke test', (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
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

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Habit was created.'), findsOneWidget);
    });

    testWidgets('2.2 Add habit smoke test', (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
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
      await tester.enterText(input, 'Other habit name');

      // Submit the form
      var submitButton = find.text('Save');
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Habit was created.'), findsOneWidget);
    });

    testWidgets('3.1 Edit habit smoke test', (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // See edit buttons
      var addButton = find.byIcon(Icons.edit);
      expect(addButton, findsWidgets);

      // Press edit button
      await tester.tap(addButton.at(0));

      // Re-render
      await tester.pump();

      // See Dialog
      expect(find.text('Edit habit'), findsOneWidget);

      // See input
      var input = find.byType(TextField);
      expect(input, findsOneWidget);

      // Enter text to input
      await tester.enterText(input, 'Wake up before 8:00');

      // Submit the form
      var submitButton = find.text('Save the changes');
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Habit title updated.'), findsOneWidget);
    });

    testWidgets('3.2. Edit habit smoke test', (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // See edit buttons
      var addButton = find.byIcon(Icons.edit);
      expect(addButton, findsWidgets);

      // Press edit button
      await tester.tap(addButton.at(1));

      // Re-render
      await tester.pump();

      // See Dialog
      expect(find.text('Edit habit'), findsOneWidget);

      // See input
      var input = find.byType(TextField);
      expect(input, findsOneWidget);

      // Enter text to input
      await tester.enterText(input, 'Wake up before 7:00');

      // Submit the form
      var submitButton = find.text('Save the changes');
      expect(submitButton, findsOneWidget);

      await tester.tap(submitButton);

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Habit title updated.'), findsOneWidget);
    });

    testWidgets('4.1. Delete habit smoke test (Confirm)',
        (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // See edit buttons
      var addButton = find.byIcon(Icons.delete);
      expect(addButton, findsWidgets);

      await tester.tap(addButton.at(0));

      // Re-render
      await tester.pump();

      // See confirmation Dialog
      expect(find.text('Are you sure?'), findsOneWidget);

      // Press delete button
      var deleteButton = find.text('Delete');
      await tester.tap(deleteButton.at(0));

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Habit deleted.'), findsOneWidget);
    });

    testWidgets('4.2. Delete habit smoke test (Cancel)',
        (WidgetTester tester) async {
      // Render the widget
      var habitsPage = await getHabitsPage(user);
      await tester.pumpWidget(makeTestableWidget(child: habitsPage));

      // Let the snapshots stream fire a snapshot
      await tester.idle();

      // Re-render
      await tester.pump();

      // See edit buttons
      var addButton = find.byIcon(Icons.delete);
      expect(addButton.at(1), findsOneWidget);

      // Press delete button
      await tester.tap(addButton.at(1));

      // Re-render
      await tester.pump();

      // See confirmation Dialog
      expect(find.text('Are you sure?'), findsOneWidget);

      // Press delete button
      var cancelButton = find.text('Cancel');
      await tester.tap(cancelButton);

      // Re-render
      await tester.pump();

      // Verify the output.
      expect(find.text('Habit deleted.'), findsNothing);
    });

  });

  group('Main screen test group', () {
    // Widget will be nested inside. It's needed so that scaffold would be accessible
    Widget makeTestableWidget({Widget home}) {
      return MultiProvider(
        providers: [Provider<FirebaseUser>.value(value: user)],
        child: MaterialApp(
          title: 'Test title',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: home,
        ),
      );
    }

    testWidgets('5. Menu is visible', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('6. Home tab is visible', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('7. Habits tab is visible', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('Habits'), findsOneWidget);
    });

    testWidgets('8. Statistics tab is visible', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('Statistics'), findsOneWidget);
    });

    testWidgets('9. Settings tab is visible', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('Settings'), findsOneWidget);
    });
  });

  group('Daily habits test group', () {
    // Widget will be nested inside. It's needed so that scaffold would be accessible
    Widget makeTestableWidget({Widget home}) {
      return MultiProvider(
        providers: [Provider<FirebaseUser>.value(value: user)],
        child: MaterialApp(
          title: 'Test title',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: home,
        ),
      );
    }

    testWidgets('10. Read archived days', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('HABIT LOG'), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('11. Read points statistics UI', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('Points: ...'), findsOneWidget);
    });

    testWidgets('12. Log day', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.text('Log day'), findsOneWidget);
    });


    testWidgets('13. Mood statistics UI', (WidgetTester tester) async {
      // Render the widget
      var home = MyHomePage(title: 'Test title');
      await tester.pumpWidget(makeTestableWidget(home: home));

      expect(find.byIcon(Emotion.emo_happy), findsNothing);
    });
  });
}
