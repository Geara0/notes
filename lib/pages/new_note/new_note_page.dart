import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/bloc/new_note/new_note_bloc.dart';
import 'package:notes/global_variables/global_variables.dart';

class NewNotePage extends StatelessWidget {
  const NewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewNoteBloc(),
      child: const _NewNotePage(),
    );
  }
}

class _NewNotePage extends StatefulWidget {
  const _NewNotePage();

  @override
  State<_NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<_NewNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('newNote.header').tr()),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(UiGlobal.padding),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'newNote.title'.tr()),
              validator: (value) {
                if (value?.trim().isNotEmpty != true) {
                  return 'newNote.titleEmptyErr'.tr();
                }
                return null;
              },
              maxLines: 1,
            ),
            const SizedBox(height: UiGlobal.mediumDivider),
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'newNote.text'.tr()),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: const Icon(Icons.save),
      ),
    );
  }

  void _save() {
    final res = _formKey.currentState?.validate();
    if (res != true) return;

    final bloc = context.read<NewNoteBloc>();
    bloc.add(
      NewNoteEvent(title: _titleController.text, text: _textController.text),
    );

    context.pop();
  }
}
