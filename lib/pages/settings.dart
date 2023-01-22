import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: const [
          CircleAvatar(
            radius: 60,
          ),
          ListTile(
            leading: Icon(Icons.settings_display),
            title: Text("Theme"),
          )
        ],
      ),
    );
  }
}
