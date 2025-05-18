import 'package:isar/isar.dart';

part 'note_dto.g.dart';

@collection
class NoteDto {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title = '';

  @Index(type: IndexType.value)
  String? text;

  DateTime time = DateTime.now();
}
