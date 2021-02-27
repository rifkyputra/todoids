part of 'theme_bloc.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({this.themeMode});

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
    };
  }
}
