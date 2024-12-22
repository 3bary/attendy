class Week {
  final int weekId;
  final int sectionId;
  final int weekNumber;

  Week({
    required this.weekId,
    required this.sectionId,
    required this.weekNumber,
  });

  factory Week.fromMap(Map<String, dynamic> map) {
    return Week(
      weekId: map['week_id'],
      sectionId: map['section_id'],
      weekNumber: map['week_number'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'week_id': weekId,
      'section_id': sectionId,
      'week_number': weekNumber,
    };
  }

  @override
  String toString() {
    return 'Week{id: $weekId, sectionId: $sectionId, weekNumber: $weekNumber}';
  }
}
