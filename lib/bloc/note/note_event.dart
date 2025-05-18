part of 'note_bloc.dart';

@immutable
sealed class _NoteEvent {}

class _NoteLoadEvent extends _NoteEvent {
  _NoteLoadEvent(this.id);

  final int id;
}

class NoteSaveEvent extends _NoteEvent {
  NoteSaveEvent({required this.title, this.text});

  final String title;
  final String? text;
}
