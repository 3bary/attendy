class Student {
  final int id;
  final String name;
  final String status;

  Student({required this.id, required this.name, required this.status});

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['student_id'],
      name: map['name'],
      status: map['status'] ?? 'Absent', // Default to "Absent" if null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'student_id': id,
      'name': name,
      'status': status, // Include status, even if it's "Absent"
    };
  }
}
