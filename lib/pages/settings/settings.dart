import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit/components/section-title.dart';

import '../../auth.dart';

class Settings extends StatefulWidget {
  final FirebaseUser user;

  bool reminders = true;

  Settings({Key key, this.user}) : super(key: key);

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
          SectionTitle(title: 'REMINDERS'),
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
              )),
          SectionTitle(title: 'USER'),
          Text(widget.user.displayName),
          MaterialButton(
            onPressed: () => authService.signOut(),
            color: Colors.redAccent,
            textColor: Colors.black,
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
