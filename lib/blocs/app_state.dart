import 'package:flutter/foundation.dart';
import 'package:flutter_todo_app/screens/app.dart';

@immutable
abstract class AppState {}

class Loading extends AppState {}

class Loaded<T> extends AppState {
  final T result;
  final dynamic data;

  Loaded(this.result, {this.data});
}

class Success extends AppState {
  final String? message;

  Success({this.message});
}

class Error extends AppState {
  final String? message;

  Error({this.message});
}

class Pending extends AppState {
  final double? millisecond;

  Pending({this.millisecond});
}

class Initialized extends AppState {
  final dynamic data;

  Initialized({this.data});
}
