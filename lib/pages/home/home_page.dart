import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/global_variables/global_variables.dart';
import 'package:notes/widgets/note/note_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('home.header').tr()),
          body: ListView.separated(
            itemCount: bloc.notes.length,
            padding: const EdgeInsets.all(UiGlobal.padding),
            itemBuilder: (context, i) {
              return Note(bloc.notes[i]);
            },
            separatorBuilder: (_, i) {
              return const SizedBox(height: UiGlobal.mediumDivider);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.go('/new_note'),
            child: const Icon(Icons.create),
          ),
        );
      },
    );
  }
}
