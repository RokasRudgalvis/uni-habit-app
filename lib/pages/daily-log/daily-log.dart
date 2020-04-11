import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/components/section-title.dart';

import '../../auth.dart';

class DailyLogPage extends StatefulWidget {
  final FirebaseUser user;


  DailyLogPage({Key key, this.user}) : super(key: key);

  @override
  _DailyLogPageState createState() => _DailyLogPageState();
}

class _DailyLogPageState extends State<DailyLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log day'),
      ),
      body: Column(
        children: [

        ],
      ),
    );

  }
}

/* TODO: List all habits with checkboxes next to titles */