import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/dto/note/note_dto.dart';
import 'package:notes/services/db_service.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<_NoteEvent, NoteState> {
  final int? id;

  NoteBloc(this.id) : super(NoteInitialState()) {
    on<NoteSaveEvent>(_saveNote);
    on<_NoteLoadEvent>(_loadNote);

    if (id == null) return;
    add(_NoteLoadEvent(id!));
  }

  FutureOr<void> _saveNote(NoteSaveEvent event, Emitter<NoteState> emit) async {
    emit(NoteProcessingState());

    final note = NoteDto(
      id: id ?? Isar.autoIncrement,
      title: event.title.trim(),
      text: event.text?.trim().isNotEmpty != true ? null : event.text!.trim(),
      time: DateTime.now(),
    );

    await DBService.db.writeTxn(
      () async => await DBService.db.noteDtos.put(note),
    );

    emit(NoteDoneState());
  }

  FutureOr<void> _loadNote(
    _NoteLoadEvent event,
    Emitter<NoteState> emit,
  ) async {
    emit(NoteProcessingState());

    final note = await DBService.db.noteDtos.get(event.id);

    if (note == null) {
      emit(NoteDoneState());
      return;
    }

    emit(NoteLoadedState(note));
  }
}
