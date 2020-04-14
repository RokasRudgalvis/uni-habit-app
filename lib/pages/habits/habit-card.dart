import 'package:flutter/material.dart';
import 'package:habit/db.dart';
import 'package:habit/models.dart';

class HabitCard extends StatefulWidget {
  String title;
  final int index;
  final Habits habits;

  HabitCard({Key key, this.title, this.index, this.habits}) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  Future<String> createDialog(BuildContext context) {
    TextEditingController inputController =
    TextEditingController(text: widget.title);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit habit'),
            content: TextField(
              decoration: InputDecoration(
                hintText: 'Enter habbit title',
              ),
              controller: inputController,
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () =>
                  {
                    Navigator.of(context)
                        .pop(inputController.text.toString())
                  },
                  textColor: Colors.black,
                  child: Text('Save the changes'))
            ],
          );
        });
  }

  Future<String> createConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Please confirm you really want to delete the habit.'),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () =>
                  {
                    Navigator.of(context)
                        .pop()
                  },
                  textColor: Colors.black,
                  child: Text('Cancel')),
              MaterialButton(
                  onPressed: () =>
                  {
                    Navigator.of(context)
                        .pop('delete')
                  },
                  textColor: Colors.black,
                  color: Colors.redAccent,
                  child: Text('Delete')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    updateHabits(String newValue) {
      if (newValue != null && newValue != widget.title) {
        // Update the view
        widget.title = newValue;
        setState(() {});

        // Update database
        var newHabitsMap =
        new Map<int, String>.from(widget.habits.habits.asMap());
        newHabitsMap.update(widget.index, (t) => newValue);

        // Convert to list
        List<String> newHabitsList = List();
        newHabitsMap.forEach((k, v) => newHabitsList.add(v));

        var newHabits = new Map();
        newHabits['id'] = widget.habits.id.toString();
        newHabits['habits'] = newHabitsList;

        DatabaseService().updateHabits(Habits.fromMap(newHabits));

        // Show snackbar
        SnackBar statusSnackbar =
        SnackBar(content: Text("Habit title updated."));
        Scaffold.of(context).showSnackBar(statusSnackbar);
      }
    }

    removeHabit() {
      var newHabitsMap =
      new Map<int, String>.from(widget.habits.habits.asMap());
      newHabitsMap.remove(widget.index);

      List<String> newHabitsList = List();
      newHabitsMap.forEach((k, v) => newHabitsList.add(v));

      var newHabits = new Map();
      newHabits['id'] = widget.habits.id.toString();
      newHabits['habits'] = newHabitsList;

      DatabaseService().updateHabits(Habits.fromMap(newHabits));

      // Show snackbar
      SnackBar statusSnackbar = SnackBar(content: Text("Habit deleted."));
      Scaffold.of(context).showSnackBar(statusSnackbar);
    }

    return Container(
        child: Card(
          child: ListTile(
            title: Text(widget.title ?? '--'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () =>
                          createDialog(context)
                              .then((newValue) => updateHabits(newValue)),
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () =>
                          createConfirmDialog(context).then((confirmed) {
                            if (confirmed == 'delete') {
                              removeHabit();
                            }
                          }),
                      icon: Icon(Icons.delete),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
