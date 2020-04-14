import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/db.dart';
import 'package:habit/models.dart';
import 'habit-card.dart';

class HabitsList extends StatefulWidget {
  final FirebaseUser user;
  final DatabaseService databaseService;

  HabitsList({Key key, this.user, this.databaseService}) : super(key: key);

  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<HabitsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<Habits>(
          stream: widget.databaseService.streamHabits(widget.user.uid),
          builder: (BuildContext context, AsyncSnapshot<Habits> snapshot) {
            if (!snapshot.hasData) return Text('Loading...');

            var habitsDoc = snapshot.data;

            return Column(
              children: List.from(habitsDoc.habits
                  .asMap()
                  .entries
                  .map((entry) => HabitCard(
                      title: entry.value, index: entry.key, habits: habitsDoc))
                  .toList()
                  .reversed),
            );
          },
        ),
      ],
    );
  }
}
