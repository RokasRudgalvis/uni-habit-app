import 'package:flutter/material.dart';
import 'package:habit/components/section-title.dart';

class Settings extends StatefulWidget {
  bool reminders = true;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SectionTitle(title: 'SETTINGS'),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton.icon(
                  color: Colors.black12,
                  icon: Icon(Icons.file_download),
                  label: Text('Export data'),
                  onPressed: () {},
                ),
                FlatButton.icon(
                  color: Colors.black12,
                  icon: Icon(Icons.file_upload),
                  label: Text('Import data'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SectionTitle(title: 'Reminders'),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: Row(
                children: [
                  Text('Off'),
                  Switch(
                      activeTrackColor: Colors.orange,
                      activeColor: Colors.orangeAccent,
                      onChanged: (value) {
                        setState(() {
                          widget.reminders = !widget.reminders;
                        });
                      },
                      value: widget.reminders),
                  Text('On'),
                ],
              ))
        ],
      ),
    );
  }
}
