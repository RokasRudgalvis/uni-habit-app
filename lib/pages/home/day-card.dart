import 'package:flutter/material.dart';
import 'package:habit/fonts/emotion_icons.dart';

class DayCard extends StatefulWidget {
  final String title;
  final IconData moodEmoji;
  final int id;

  const DayCard({Key key, this.title, this.moodEmoji, this.id})
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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit))
          ],),
        ))
        /*child: Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2020 04 01'),
              Container(
                child: Wrap(
                  children: <Widget>[
                    Container(
                        width: 40.0,
                        height: 40.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(widget.moodEmoji)])),
                    SizedBox(width: 10),
                    Container(
                        width: 40.0,
                        height: 40.0,
                        child: FlatButton(
                          color: Colors.orange,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            */ /*...*/ /*
                          },
                          child: Row(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Icon(Icons.edit),
                            ],
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ])),*/
        );
  }
}
