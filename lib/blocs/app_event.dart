import 'package:flutter/foundation.dart';

@immutable
abstract class AppEvent {
  get data => null;
}

class Initializing extends AppEvent {
  final dynamic data;

  Initializing({this.data});
}

class Get<T> extends AppEvent {
  final T request;
  final dynamic data;

  Get({required this.request, this.data});
}

class Update extends AppEvent {}

class Delete extends AppEvent {}

class Refresh extends AppEvent {
  final args;

  Refresh({this.args});
}
