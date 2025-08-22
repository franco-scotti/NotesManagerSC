class Note {
  final String title;
  final String description;
  final String? observation;

  Note({
    required this.title,
    required this.description,
    this.observation = "",
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'observation': observation,
      };

  factory Note.fromMap(Map<dynamic, dynamic> map) => Note(
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        observation: map['observation'] ?? '',
      );
}
