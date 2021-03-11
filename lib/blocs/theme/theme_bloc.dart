// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
              themeMode: ThemeMode.system, themeColor: Colors.deepPurple),
        );

  toggleDarkTheme({bool useSystemTheme = false}) {
    if (useSystemTheme) {
      emit(ThemeState(
          themeMode: ThemeMode.system, themeColor: state.themeColor));
      return;
    }

    if (state.themeMode == ThemeMode.dark) {
      emit(
          ThemeState(themeMode: ThemeMode.light, themeColor: state.themeColor));
    } else {
      emit(ThemeState(themeMode: ThemeMode.dark, themeColor: state.themeColor));
    }
  }

  swithColor({Color color = Colors.black}) {
    emit(ThemeState(themeMode: state.themeMode, themeColor: color));
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    ThemeMode modeFromJson = ThemeMode.values[json['themeMode']];
    Color colorFromJson = Color(json['themeColor']);
    return ThemeState(themeMode: modeFromJson, themeColor: colorFromJson);
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return state.toJson();
  }

  // @override
  // int fromJson(Map<String, dynamic> json) => json['value'] as int;

  // @override
  // Map<String, int> toJson(int state) => {'value': state};
}
