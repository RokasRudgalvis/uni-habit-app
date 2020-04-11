import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/fonts/emotion_icons.dart';
import 'package:habit/pages/daily-log/daily-log.dart';
import 'package:habit/pages/settings/settings.dart';

class DayCard extends StatefulWidget {
  final String title;
  final IconData moodEmoji;
  final int id;
  final FirebaseUser user;

  const DayCard({Key key, this.title, this.user, this.moodEmoji, this.id})
      : super(key: key);

  @override
  _DayCardState createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Card(
            child: ListTile(
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(widget.moodEmoji)]),
          title: Text(widget.title),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyLogPage(user: widget.user)),
                );
              }, icon: Icon(Icons.edit)),
            ],
          ),
        )));
  }
}
