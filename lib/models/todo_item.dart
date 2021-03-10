import 'dart:convert';

class TodoItem {
  final bool completed;
  final String name;
  final int id;

  TodoItem({
    required this.completed,
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'isCompleted': completed,
      'content': name,
    };
  }

  factory TodoItem.fromMap(Map<dynamic, dynamic> map, {required int id}) {
    return TodoItem(
      completed: map['isCompleted'],
      name: map['content'],
      id: id,
      // id: map.i
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source, id) =>
      TodoItem.fromMap(json.decode(source), id: id);

  TodoItem copyWith({
    bool? completed,
    String? name,
  }) {
    return TodoItem(
      completed: completed ?? this.completed,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  @override
  String toString() => 'TodoItem(completed: $completed, name: $name)';
}
