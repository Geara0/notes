import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/bloc/note/note_bloc.dart';
import 'package:notes/global_variables/global_variables.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, this.id});

  final int? id;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final GlobalKey<_NewNotePageState> _pageKey = GlobalKey();

  bool get _hasUnsavedChanges {
    final state = _pageKey.currentState;
    if (state == null) return false;

    return state._savedText != state._textController.text ||
        state._savedTitle != state._titleController.text;
  }

  Future<bool?> _showExitConfirmationDialog() async {
    return showAdaptiveDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('note.popDialog.header').tr(),
            content: const Text('note.popDialog.text').tr(),
            actions: [
              TextButton(
                onPressed: () => context.pop(false),
                child: const Text('note.popDialog.cancel').tr(),
              ),
              TextButton(
                onPressed: () => context.pop(true),
                child: const Text('note.popDialog.ok').tr(),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        final bool shouldPop =
            !_hasUnsavedChanges ||
            (await _showExitConfirmationDialog() ?? false);

        if (context.mounted && shouldPop) context.pop();
      },
      child: BlocProvider(
        create: (context) => NoteBloc(widget.id),
        child: _NewNotePage(key: _pageKey, isEdit: widget.id != null),
      ),
    );
  }
}

class _NewNotePage extends StatefulWidget {
  const _NewNotePage({super.key, required this.isEdit});

  final bool isEdit;

  @override
  State<_NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<_NewNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  final _editedDate = ValueNotifier<DateTime?>(null);

  String _savedTitle = '';
  String _savedText = '';

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _editedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('yyyy MMM d HH:mm');

    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        switch (state) {
          case NoteInitialState():
            return;
          case NoteLoadedState():
            _titleController.text = state.dto.title;
            _textController.text = state.dto.text ?? '';
            _savedTitle = state.dto.title;
            _savedText = state.dto.text ?? '';
            _editedDate.value = state.dto.time.toLocal();
          case NoteProcessingState():
            // сейчас не показываем индикатор, тк хранилище локальное
            // и взаимодействие быстрое
            return;
          case NoteDoneState():
            context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.isEdit ? 'note.editHeader' : 'note.newHeader').tr(),
        ),
        bottomNavigationBar:
            widget.isEdit
                ? ValueListenableBuilder(
                  valueListenable: _editedDate,
                  builder: (context, value, child) {
                    if (value == null) return const SizedBox.shrink();

                    return SafeArea(
                      child: Text(
                        textAlign: TextAlign.center,
                        'note.lastEdit'.tr(args: [timeFormat.format(value)]),
                      ),
                    );
                  },
                )
                : null,
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(UiGlobal.padding),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'note.title'.tr()),
                validator: (value) {
                  if (value?.trim().isNotEmpty != true) {
                    return 'note.titleEmptyErr'.tr();
                  }
                  return null;
                },
                maxLines: 1,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: UiGlobal.mediumDivider),
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'note.text'.tr()),
                maxLines: null,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _save,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  void _save() {
    final res = _formKey.currentState?.validate();
    if (res != true) return;

    final bloc = context.read<NoteBloc>();
    bloc.add(
      NoteSaveEvent(title: _titleController.text, text: _textController.text),
    );
  }
}
