import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => AboutScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Todo App '),
            Text('Created by Rifky Adni Putra'),
          ],
        ),
      ),
    );
  }
}
