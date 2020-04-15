import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/db.dart';
import 'package:habit/fonts/emotion_icons.dart';

import '../../models.dart';

class MoodButtonList extends StatefulWidget {
  final FirebaseUser user;
  DailyLog dailyLog;

  MoodButtonList({Key key, this.user, this.dailyLog}) : super(key: key);

  @override
  _MoodButtonListState createState() => _MoodButtonListState();
}

class _MoodButtonListState extends State<MoodButtonList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DailyLog>(
        stream: DatabaseService()
      .streamSingleDailyLog(widget.user.uid, widget.dailyLog.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading...');

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MoodButton(
                icon: Emotion.emo_unhappy,
                active: snapshot.data.mood == 0,
                dailyLog: widget.dailyLog,
                user: widget.user,
                index: 0,
              ),
              MoodButton(
                icon: Emotion.emo_displeased,
                active: snapshot.data.mood == 1,
                dailyLog: widget.dailyLog,
                user: widget.user,
                index: 1,
              ),
              MoodButton(
                icon: Emotion.emo_sleep,
                active: snapshot.data.mood == 2,
                dailyLog: widget.dailyLog,
                user: widget.user,
                index: 2,
              ),
              MoodButton(
                icon: Emotion.emo_happy,
                active: snapshot.data.mood == 3,
                dailyLog: widget.dailyLog,
                user: widget.user,
                index: 3,
              ),
              MoodButton(
                icon: Emotion.emo_squint,
                active: snapshot.data.mood == 4,
                dailyLog: widget.dailyLog,
                user: widget.user,
                index: 4,
              ),
            ],
          );
        });
  }
}

class MoodButton extends StatelessWidget {
  final IconData icon;
  final bool active;
  DailyLog dailyLog;
  final FirebaseUser user;
  final int index;

  MoodButton({Key key, this.icon,  this.index, this.user, this.dailyLog, this.active})
      : super(key: key);

  Color getColor(bool active) {
    if (active) {
      return Colors.orangeAccent;
    }

    return Colors.white;
  }

  Future<void> setMood() {
    dailyLog.mood = index;
    DatabaseService().updateDailyLog(user.uid, dailyLog);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Ink(
          decoration: ShapeDecoration(
            color: getColor(active),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.black,
            onPressed: () => setMood(),
          ),
        ),
      ),
    );
  }
}
