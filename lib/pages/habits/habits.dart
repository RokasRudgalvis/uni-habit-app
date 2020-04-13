import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/components/section-title.dart';
import 'package:habit/db.dart';
import 'package:habit/models.dart';
import 'habits-list.dart';

class HabitsPage extends StatefulWidget {
  final FirebaseUser user;
  final DatabaseService databaseService;

  HabitsPage({Key key, this.user, this.databaseService}) : super(key: key);

  @override
  _HabitsState createState() => _HabitsState();
}

class _HabitsState extends State<HabitsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<String> createDialog(BuildContext context) {
    TextEditingController inputController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create new habit'),
            content: TextField(
              decoration: InputDecoration(
                hintText: 'Enter habit title',
              ),
              controller: inputController,
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () => {
                        Navigator.of(context)
                            .pop(inputController.text.toString())
                      },
                  textColor: Colors.black,
                  child: Text('Save'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    createHabit(String title) {
      print('new habbit');
      print(title);
      if (title != null) {
        // Get current habits
        widget.databaseService.getHabits(widget.user.uid).then((v) {
          var newHabitsMap = new Map<int, String>.from(v.habits.asMap());
          newHabitsMap[v.habits.length] = title;

          List<String> newHabitsList = List();
          newHabitsMap.forEach((k, v) => newHabitsList.add(v));

          var newHabits = new Map();
          newHabits['id'] = widget.user.uid;
          newHabits['habits'] = newHabitsList;

          widget.databaseService.updateHabits(Habits.fromMap(newHabits));

          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text("Habit was created.")));
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionTitle(title: 'ALL HABITS'),
            HabitsList(
              user: widget.user,
              databaseService: widget.databaseService,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            createDialog(context).then((title) => createHabit(title)),
        label: Text('New habbit'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
