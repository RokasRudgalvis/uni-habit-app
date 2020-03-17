import 'package:flutter/material.dart';
import 'package:habit/fonts/emotion_icons.dart';

class SectionTitle extends StatefulWidget {
  final String title;

  const SectionTitle({Key key, this.title}) : super(key: key);

  @override
  _SectionTitleState createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
      widget.title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ));
  }
}
