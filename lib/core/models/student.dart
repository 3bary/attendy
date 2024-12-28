class Student {
  final int id;
  final String name;
  final String status;
  final String level;

  Student({required this.id, required this.name, required this.status, required this.level});

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['student_id'],
      name: map['name'],
      level: map['level'],
      status: map['status'] ?? 'Absent', // Default to "Absent" if null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'student_id': id,
      'name': name,
      'level': level,
      'status': status, // Include status, even if it's "Absent"
    };
  }
}
