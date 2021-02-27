import 'package:flutter/material.dart';
import 'package:flutter_todo_app/main.dart';

class SettingsScreen extends StatelessWidget {
  static route() {
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
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context),
          ),
        ],
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
