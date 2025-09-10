class Note {
  final int? id;
  final String title;
  final String description;
  final String? observation;

  const Note({
    this.id,
    required this.title,
    required this.description,
    this.observation,
  });

  static const empty = Note(
    id: null,
    title: '',
    description: '',
    observation: '',
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'observation': observation,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      observation: map['observation'],
    );
  }
}
