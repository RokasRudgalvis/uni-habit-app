import 'package:flutter/material.dart';
import 'package:habit/fonts/emotion_icons.dart';

class HabitCard extends StatefulWidget {
  final String title;

  const HabitCard({Key key, this.title}) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: ListTile(
          title: Text(widget.title),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Wrap(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
