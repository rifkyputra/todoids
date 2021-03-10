import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

import 'package:flutter_todo_app/blocs/app_event.dart';
import 'package:flutter_todo_app/blocs/app_state.dart';
import 'package:flutter_todo_app/models/todo_item.dart';

part 'list_todo_event.dart';
part 'list_todo_state.dart';

enum ListTodoTypes {
  All,
  Completed,
  Ongoing,
}

class ListTodoBloc extends Bloc<AppEvent, AppState> {
  ListTodoBloc() : super(Initialized());

  ValueListenable<Box>? listenable;
  VoidCallback mapListenable = () {};
  ListTodoTypes currentTodoView = ListTodoTypes.All;

  @override
  close() async {
    listenable?.removeListener(mapListenable);

    await super.close();
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    yield Loading();

    if (event is Initializing) {
      listenable = (event.data as Box).listenable();

      mapListenable = () {
        final List<TodoItem> todos = todosFromListenable();

        this.add(EmitList(todos));
      };
      mapListenable.call();
      listenable?.addListener(mapListenable);
    } else if (event is Get<ListTodoTypes>) {
      if (listenable == null) {
        yield Loaded<List<TodoItem>>([]);
        return;
      }

      currentTodoView = event.request;

      final List<TodoItem> todos = todosFromListenable();

      this.add(EmitList(todos));
    } else if (event is EmitList) {
      yield Loading();
      List<TodoItem> items = event.data;

      switch (currentTodoView) {
        case ListTodoTypes.All:
          items = event.data;
          break;
        case ListTodoTypes.Completed:
          items = event.data.where((v) => v.completed).toList();
          break;
        case ListTodoTypes.Ongoing:
          items = event.data.where((v) => !v.completed).toList();
          break;
      }

      print(items);

      yield Loaded<List<TodoItem>>(items);
    }
  }

  List<TodoItem> todosFromListenable() {
    final List<TodoItem> todos = [];

    // try {
    print(listenable?.value.values);
    final ts = listenable?.value.values.toList().asMap();

    ts?.forEach((i, v) {
      final TodoItem todo = TodoItem.fromMap(v, id: i);

      todos.add(todo);
    });
    // for (int i in ts) {}
    // for (var item in listenable.value.values) {
    // }

    return todos;
    // } catch (e) {
    //   print(e);
    //   return [];
    // }
  }
}
