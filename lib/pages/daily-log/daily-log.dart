import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/auth.dart';
import 'package:habit/components/section-title.dart';
import 'package:habit/db.dart';
import 'package:habit/pages/daily-log/mood-button-list.dart';
import 'package:provider/provider.dart';
import '../../models.dart';
import 'check-card.dart';

class DailyLogPage extends StatefulWidget {
  DailyLog dailyLog;
  FirebaseUser user;

  DailyLogPage({Key key, this.dailyLog, this.user}) : super(key: key);

  @override
  _DailyLogPageState createState() => _DailyLogPageState();
}

class _DailyLogPageState extends State<DailyLogPage> {
  String getTitle() {
    var date = DateTime.now().toString();

    if (widget.dailyLog != null) {
      date = widget.dailyLog.date.toDate().toString();
    }

    var year = DateTime.parse(date).year;
    var month = DateTime.parse(date).month;
    var day = DateTime.parse(date).day;
    return 'Log: ' + [year, month, day].join(' ');
  }

  FirebaseUser _user;

  setUser(FirebaseUser user) {
    _user = user;
  }

  @override
  Widget build(BuildContext context) {
    setUser(Provider.of<FirebaseUser>(context));

    bool isHabitDone(String habitTitle) {
      var result = false;
      widget.dailyLog.complete.forEach((completeHabitTitle) {
        if (completeHabitTitle == habitTitle) {
          result = true;
        }
      });

      return result;
    }

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
        ),
        body: Column(
          children: [
            SectionTitle(
              title: 'Choose mood',
            ),
            MoodButtonList(
              dailyLog: widget.dailyLog,
              user: widget.user,),
            SectionTitle(
              title: 'Check done habits',
            ),
            StreamBuilder<Habits>(
              stream: DatabaseService().streamHabits(_user.uid),
              builder: (BuildContext context, AsyncSnapshot<Habits> snapshot) {
                if (!snapshot.hasData) return Text('Loading...');

                var habits = snapshot.data.habits;

                return Column(
                  children: List.from(habits
                      .map((habitTitle) => CheckCard(
                            title: habitTitle,
                            dailyLog: widget.dailyLog,
                            user: widget.user,
                            isChecked: isHabitDone(habitTitle),
                          ))
                      .toList()
                      .reversed),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/* TODO: List all habits with checkboxes next to titles */
