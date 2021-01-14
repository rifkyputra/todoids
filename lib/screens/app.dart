import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: CupertinoColors.systemIndigo),
        primaryColor: Colors.deepPurple,
        accentColor: Colors.purpleAccent,
        accentIconTheme: IconThemeData(color: Colors.blue, size: 40),
        typography: Typography.material2018(),
        iconTheme: IconThemeData(color: Colors.black, size: 40),
        accentTextTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white10,
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
