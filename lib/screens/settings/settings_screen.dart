import 'package:flutter/material.dart';
import 'package:todoids/main.dart';

class SettingsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) {
        return SettingsScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete All Todo'),
            onTap: () {
              todoBox.clear();
            },
          ),
        ],
      ),
    );
  }
}
