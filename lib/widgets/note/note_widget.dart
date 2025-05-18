import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/dto/note/note_dto.dart';
import 'package:notes/global_variables/global_variables.dart';

class Note extends StatelessWidget {
  const Note(this.dto, {super.key});

  final NoteDto dto;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/note/${dto.id}'),
        child: Padding(
          padding: const EdgeInsets.all(UiGlobal.mediumDivider),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dto.title,
                style: textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: UiGlobal.smallDivider),
              if (dto.text != null)
                Text(dto.text!, maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
