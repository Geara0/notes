part of 'note_widget.dart';

class _NoteContent extends StatelessWidget {
  const _NoteContent(this.dto);

  final NoteDto dto;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final timeFormat = DateFormat('MMM d HH:mm');

    return Padding(
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
          if (dto.text != null) ...[
            Text(dto.text!, maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: UiGlobal.smallDivider),
          ],
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              timeFormat.format(dto.time.toLocal()),
              style: textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
