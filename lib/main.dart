import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './screens/app.dart';

Box todoBox;
void main() async {
  await Hive.initFlutter();
  todoBox = await Hive.openBox('todoBox');
  runApp(App());
}
