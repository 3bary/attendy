class Section {
  final int sectionId;
  final String name;
  final String description;

  // Constructor
  Section({
    required this.sectionId,
    required this.name,
    required this.description,
  });

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      sectionId: map['section_id'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'section_id': sectionId,
      'name': name,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Section{id: $sectionId, name: $name, description: $description}';
  }
}
