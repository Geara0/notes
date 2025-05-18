import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/new_note/new_note_bloc.dart';
import 'package:notes/global_variables/global_variables.dart';

class NewNotePage extends StatelessWidget {
  const NewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewNoteBloc(),
      child: _NewNotePage(),
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
      appBar: AppBar(title: Text('New note')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(UiGlobal.padding),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value?.isNotEmpty != true) return 'Title can not be empty';
                return null;
              },
            ),
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Text'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: Icon(Icons.save),
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
  }
}
