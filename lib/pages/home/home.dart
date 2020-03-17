import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habit/components/section-title.dart';
import 'package:habit/fonts/emotion_icons.dart';

import 'day-card.dart';

class Home extends StatefulWidget {
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
                  DayCard(
                      title: '2020 04 09',
                      moodEmoji: Emotion.emo_sunglasses,
                      id: 1),
                  DayCard(
                      title: '2020 04 08',
                      moodEmoji: Emotion.emo_squint,
                      id: 1),
                  DayCard(
                      title: '2020 04 07', moodEmoji: Emotion.emo_happy, id: 0),
                  DayCard(
                      title: '2020 04 05', moodEmoji: Emotion.emo_sleep, id: 3),
                  DayCard(
                      title: '2020 04 04',
                      moodEmoji: Emotion.emo_unhappy,
                      id: 2),
                  DayCard(
                      title: '2020 04 03', moodEmoji: Emotion.emo_cry, id: 1),
                  DayCard(
                      title: '2020 04 09',
                      moodEmoji: Emotion.emo_sunglasses,
                      id: 1),
                  DayCard(
                      title: '2020 04 08',
                      moodEmoji: Emotion.emo_squint,
                      id: 1),
                  DayCard(
                      title: '2020 04 07', moodEmoji: Emotion.emo_happy, id: 0),
                  DayCard(
                      title: '2020 04 05', moodEmoji: Emotion.emo_sleep, id: 3),
                  DayCard(
                      title: '2020 04 04',
                      moodEmoji: Emotion.emo_unhappy,
                      id: 2),
                  DayCard(
                      title: '2020 04 03', moodEmoji: Emotion.emo_cry, id: 1),
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
