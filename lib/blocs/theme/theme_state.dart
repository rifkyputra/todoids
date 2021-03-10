part of 'theme_bloc.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
    };
  }
}
