import 'package:hive/hive.dart';
part 'notes_manager.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String? observation;

  Note({
    required this.title,
    required this.description,
    this.observation = "",
  });
}
