import 'package:isar/isar.dart';

part 'note_dto.g.dart';

@collection
class NoteDto {
  NoteDto({required this.title, this.text, required DateTime time})
    : time = time.toUtc();

  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title;

  @Index(type: IndexType.value)
  String? text;

  DateTime time;
}
