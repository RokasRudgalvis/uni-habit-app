import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/db.dart';
import 'package:habit/models.dart';
import 'habit-card.dart';

class HabitsList extends StatefulWidget {
  final FirebaseUser user;

  HabitsList({Key key, this.user}) : super(key: key);

  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<HabitsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<Habits>(
          stream: DatabaseService().streamHabits(widget.user.uid),
          builder: (BuildContext context, AsyncSnapshot<Habits> snapshot) {
            var habitsDoc = snapshot.data;

            if (habitsDoc == null) {
              return Text('Loading...');
            }

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
