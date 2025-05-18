part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitialState extends NoteState {}

final class NoteLoadedState extends NoteState {
  NoteLoadedState(this.dto);

  final NoteDto dto;
}

final class NoteProcessingState extends NoteState {}

final class NoteDoneState extends NoteState {}
