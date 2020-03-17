import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Card(
            child: Column(
          children: [
            ListTile(title: Text('Points')),
            Container(
                color: Colors.grey,
                child: SizedBox(
                  height: 240.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.image,
                        size: 70.0,
                        color: Colors.black38,
                      )
                    ],
                  ),
                )),
          ],
        )),
        SizedBox(height: 24.0),
        Card(
          child: Column(
            children: [
              ListTile(title: Text('Mood')),
              Container(
                  color: Colors.grey,
                  child: SizedBox(
                    height: 240.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.image,
                          size: 70.0,
                          color: Colors.black38,
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 24.0),
      ]),
    ));
  }
}
