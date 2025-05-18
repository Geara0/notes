import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/dto/note/note_dto.dart';
import 'package:notes/services/db_service.dart';

part 'new_note_event.dart';
part 'new_note_state.dart';

class NewNoteBloc extends Bloc<NewNoteEvent, NewNoteState> {
  NewNoteBloc() : super(NewNoteInitialState()) {
    on<NewNoteEvent>(_newNote);
  }

  FutureOr<void> _newNote(
    NewNoteEvent event,
    Emitter<NewNoteState> emit,
  ) async {
    emit(NewNoteProcessingState());

    final note =
        NoteDto()
          ..text = event.text?.isNotEmpty != true ? null : event.text
          ..title = event.title;

    await DBService.db.writeTxn(
      () async => await DBService.db.noteDtos.put(note),
    );

    emit(NewNoteDoneState());
  }
}
