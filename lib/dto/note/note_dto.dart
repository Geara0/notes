import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes/dao/note/note_dao.dart';

part 'note_dto.freezed.dart';

@freezed
abstract class NoteDto with _$NoteDto {
  const NoteDto._();

  @Assert('title.isNotEmpty')
  @Assert('text?.isNotEmpty != false')
  factory NoteDto({
    required String title,
    String? text,
    required DateTime time,
    required int id,
  }) = _NoteDto;

  factory NoteDto.fromDao(NoteDao dao) =>
      NoteDto(title: dao.title, text: dao.text, time: dao.time, id: dao.id);

  NoteDao toDao() => NoteDao(title: title, text: text, time: time, id: id);
}
