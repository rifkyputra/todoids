part of 'theme_bloc.dart';

class ThemeState {
  final ThemeMode themeMode;
  final Color themeColor;

  ThemeState({required this.themeMode, required this.themeColor});

  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.index, 'themeColor': themeColor.value,};
  }
}
