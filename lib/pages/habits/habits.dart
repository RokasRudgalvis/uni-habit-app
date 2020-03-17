import 'package:flutter/material.dart';
import 'package:habit/components/section-title.dart';

import 'habit-card.dart';

class Habits extends StatefulWidget {
  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionTitle(title: 'ALL HABITS'),
            HabitCard(title: 'Wake up before 9:00'),
            HabitCard(title: 'Study for 2 hours'),
            HabitCard(title: 'Drink 2l of water'),
            HabitCard(title: 'Prepare my own food'),
            HabitCard(title: 'Eat 3000 calories'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('New habbit'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
