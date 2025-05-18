part of 'new_note_bloc.dart';

@immutable
sealed class NewNoteState {}

final class NewNoteInitialState extends NewNoteState {}

final class NewNoteProcessingState extends NewNoteState {}

final class NewNoteDoneState extends NewNoteState {}
