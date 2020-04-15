import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/components/section-title.dart';
import 'package:habit/pages/daily-log/daily-log.dart';
import '../../models.dart';

class EditDailyLogPage extends StatefulWidget {
  final FirebaseUser user;
  final DailyLog dailyLog;

  EditDailyLogPage({Key key, this.user, @required this.dailyLog}) : super(key: key);

  @override
  _EditDailyLogPageState createState() => _EditDailyLogPageState();
}

class _EditDailyLogPageState extends State<EditDailyLogPage> {
  @override
  Widget build(BuildContext context) {
    return DailyLogPage(dailyLog: widget.dailyLog, user: widget.user);

  }
}