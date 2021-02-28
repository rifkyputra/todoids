import 'dart:convert';

class TodoItem {
  final bool completed;
  final String name;
  final int id;

  TodoItem({
    this.completed,
    this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'isCompleted': completed,
      'content': name,
    };
  }

  factory TodoItem.fromMap(Map<dynamic, dynamic> map, {int id}) {
    if (map == null) return null;

    return TodoItem(
      completed: map['isCompleted'],
      name: map['content'],
      id: id,
      // id: map.i
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source));

  TodoItem copyWith({
    bool completed,
    String name,
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
