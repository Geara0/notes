import 'package:isar/isar.dart';

part 'note_dao.g.dart';

@collection
class NoteDao {
  NoteDao({
    this.id = Isar.autoIncrement,
    required this.title,
    this.text,
    required DateTime time,
  }) : time = time.toUtc();

  Id id;

  @Index(type: IndexType.value)
  String title;

  @Index(type: IndexType.value)
  String? text;

  DateTime time;
}
