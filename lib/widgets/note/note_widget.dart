import 'package:flutter/material.dart';
import 'package:notes/dto/note/note_dto.dart';

class Note extends StatelessWidget {
  const Note(this.dto, {super.key});

  final NoteDto dto;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(dto.title), if (dto.text != null) Text(dto.text!)],
      ),
    );
  }
}
