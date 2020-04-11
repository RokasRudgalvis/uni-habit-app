import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habit/components/section-title.dart';
import 'package:habit/fonts/emotion_icons.dart';

import 'daily-log-list.dart';
import 'day-card.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  Home({Key key, this.user}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            // Points
            Container(
              color: Colors.blueGrey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 40.0),
                  child: Column(
                    children: [
                      Text.rich(TextSpan(
                          text: 'Points: ',
                          children: [
                            TextSpan(
                                text: '123',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87))
                          ],
                          style:
                              TextStyle(fontSize: 32.0, color: Colors.black54)))
                    ],
                  )),
            ),
            // Days
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SectionTitle(title: 'HABIT LOG'),
                  DailyLogList(user: widget.user),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ])),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Log day'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
