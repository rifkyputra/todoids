import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './screens/app.dart';
import 'package:path_provider/path_provider.dart';

Box todoBox = Hive.box('initBox');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  todoBox = await Hive.openBox('todoBox');

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: (await getTemporaryDirectory()));

  runApp(App());
}
