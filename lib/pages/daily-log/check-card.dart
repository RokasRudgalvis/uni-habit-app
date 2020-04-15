import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/db.dart';

import '../../models.dart';

class CheckCard extends StatefulWidget {
  final String title;
  final FirebaseUser user;
  DailyLog dailyLog;
  bool isChecked;

  CheckCard({Key key, this.title, this.user, this.isChecked, this.dailyLog})
      : super(key: key);

  @override
  _CheckCardState createState() => _CheckCardState();
}

class _CheckCardState extends State<CheckCard> {
  void _onDoneChanged(bool newValue) => setState(() {
        widget.isChecked = newValue;

        if (widget.isChecked) {
          widget.dailyLog.complete.add(widget.title);
          DatabaseService().addPoint(widget.user.uid);
        } else {
          widget.dailyLog.complete.remove(widget.title);
          DatabaseService().removePoint(widget.user.uid);
        }

        // update database

        //print(widget.dailyLog.id);

        DatabaseService().updateDailyLog(widget.user.uid, widget.dailyLog);
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Card(
        child: ListTile(
          onTap: () => _onDoneChanged(!widget.isChecked),
          title: Text(widget.title),
          trailing:
              Checkbox(value: widget.isChecked, onChanged: _onDoneChanged),
        ),
      ),
    );
  }
}
