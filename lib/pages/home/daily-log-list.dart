import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/db.dart';
import 'package:habit/fonts/emotion_icons.dart';
import 'package:habit/models.dart';

import 'day-card.dart';

class DailyLogList extends StatefulWidget {
  final FirebaseUser user;

  DailyLogList({Key key, this.user}) : super(key: key);

  @override
  _DailyLogListPage createState() => _DailyLogListPage();
}

class _DailyLogListPage extends State<DailyLogList> {
  IconData getEmoji(DailyLog dailyLog) {
    switch(dailyLog.mood) {
      case 0:
        return Emotion.emo_unhappy;
      case 1:
        return Emotion.emo_displeased;
      case 2:
        return Emotion.emo_sleep;
      case 3:
        return Emotion.emo_happy;
      case 4:
        return Emotion.emo_squint;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<List<DailyLog>>(
          stream: DatabaseService().streamDailyLog(widget.user.uid),
          builder:
              (BuildContext context, AsyncSnapshot<List<DailyLog>> snapshot) {
            if (!snapshot.hasData) return Text('Loading...');

            var dailyLogDoc = snapshot.data;

            return Column(
              children: List.from(dailyLogDoc
                  .asMap()
                  .entries
                  .map((entry) {
                    var year =
                        DateTime.parse(entry.value.date.toDate().toString())
                            .year;
                    var month =
                        DateTime.parse(entry.value.date.toDate().toString())
                            .month;
                    var day =
                        DateTime.parse(entry.value.date.toDate().toString())
                            .day;
                    var list = [year, month, day];

                    return DayCard(
                      title: list.join(' '),
                      moodEmoji: getEmoji(entry.value),
                      id: 1,
                      dailyLog: entry.value,
                      user: widget.user,
                    );
                  })),
            );
          },
        ),
        SizedBox(height: 24.0),
      ],
    );
  }
}
