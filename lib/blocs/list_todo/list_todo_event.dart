part of 'list_todo_bloc.dart';

class EmitList extends AppEvent {
  final List<TodoItem> data;

  EmitList(
    this.data,
  );
}
