import 'dart:async';

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
            themeMode: ThemeMode.system,
          ),
        );

  toggleDarkTheme({bool useSystemTheme = false}) {
    if (useSystemTheme) {
      emit(ThemeState(themeMode: ThemeMode.system));
      return;
    }

    if (state.themeMode == ThemeMode.dark) {
      emit(ThemeState(themeMode: ThemeMode.light));
    } else {
      emit(ThemeState(themeMode: ThemeMode.dark));
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    ThemeMode modeFromJson = ThemeMode.values[json['themeMode']];
    return ThemeState(themeMode: modeFromJson);
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
