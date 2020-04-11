import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habit/components/section-title.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<List<DailyLog>>(
          stream: DatabaseService().streamDailyLog(widget.user.uid),
          builder:
              (BuildContext context, AsyncSnapshot<List<DailyLog>> snapshot) {
            var dailyLogDoc = snapshot.data;

            if (dailyLogDoc == null) {
              return Text('Loading...');
            }

            print(dailyLogDoc);

            return Column(
              children: List.from(dailyLogDoc
                  .asMap()
                  .entries
                  .map((entry) {
                    var year = DateTime.parse(entry.value.date.toDate().toString()).year;
                    var month = DateTime.parse(entry.value.date.toDate().toString()).month;
                    var day = DateTime.parse(entry.value.date.toDate().toString()).day;
                    var list = [year, month, day];

                    return DayCard(title: list.join(' '), moodEmoji: Emotion.emo_sunglasses, id: 1, user: widget.user);
                  })
                  .toList()
                  .reversed),
            );
          },
        ),
        SizedBox(height: 24.0),
      ],
    );
  }
}
