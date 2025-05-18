import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/dto/note/note_dto.dart';
import 'package:notes/global_variables/global_variables.dart';

part 'note_content.dart';

class Note extends StatelessWidget {
  const Note(this.dto, {super.key, required this.onDelete});

  final NoteDto dto;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    final actionPane = ActionPane(
      motion: const BehindMotion(),
      dismissible: DismissiblePane(
        onDismissed: onDelete,
        dismissThreshold: 0.5,
      ),
      openThreshold: 0.5,
      closeThreshold: 0.5,
      children: [
        SlidableAction(
          onPressed: null,
          backgroundColor: colorScheme.errorContainer,
          foregroundColor: colorScheme.onErrorContainer,
          icon: Icons.delete,
        ),
      ],
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Slidable(
        key: ValueKey(dto.id),
        startActionPane: actionPane,
        endActionPane: actionPane,
        child: InkWell(
          onTap: () => context.go('/note/${dto.id}'),
          child: _NoteContent(dto),
        ),
      ),
    );
  }
}
