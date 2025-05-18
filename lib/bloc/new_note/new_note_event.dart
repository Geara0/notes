part of 'new_note_bloc.dart';

@immutable
class NewNoteEvent {
  const NewNoteEvent({required this.title, this.text});

  final String title;
  final String? text;
}
