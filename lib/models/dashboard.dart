import 'dart:convert';

class DashboardStat {
  final int allTodos;
  final int completed;
  final int ongoing;

  DashboardStat({
    this.allTodos,
    this.completed,
    this.ongoing,
  });

  DashboardStat copyWith({
    int allTodos,
    int completed,
    int ongoing,
  }) {
    return DashboardStat(
      allTodos: allTodos ?? this.allTodos,
      completed: completed ?? this.completed,
      ongoing: ongoing ?? this.ongoing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allTodos': allTodos,
      'completed': completed,
      'ongoing': ongoing,
    };
  }

  factory DashboardStat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DashboardStat(
      allTodos: map['allTodos'],
      completed: map['completed'],
      ongoing: map['ongoing'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardStat.fromJson(String source) =>
      DashboardStat.fromMap(json.decode(source));

  @override
  String toString() =>
      'DashboardStat(allTodos: $allTodos, completed: $completed, ongoing: $ongoing)';
}
