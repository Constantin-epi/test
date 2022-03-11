import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xffff4300),
      ),
      body: ListView(
                padding: const EdgeInsets.all(8.0),
                itemExtent: 60.0,
              children: <Widget>[
                Card(
                  child: Text('settings 1'),
                ),
                Card(
                  child: Text('settings 2'),
                ),
                Card(
                  child: Text('settings 3'),
                ),
                Card(
                  child: Text('settings 4'),
                ),
                Card(
                  child: Text('settings 5'),
                ),
              ]
            ),
    );
  }
}