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

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    // pagination
    final bloc = context.read<HomeBloc>();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent - 1000) {
        bloc.add(HomeGetNotesEvent());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('home.header').tr()),
          body: RefreshIndicator(
            onRefresh: () {
              bloc.add(HomeRefreshEvent());
              return bloc.stream.first;
            },
            child: ListView.separated(
              clipBehavior: Clip.none,
              controller: _scrollController,
              itemCount: bloc.notes.length,
              padding:
                  const EdgeInsets.all(UiGlobal.padding) +
                  EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
              itemBuilder: (context, i) {
                return Note(bloc.notes[i]);
              },
              separatorBuilder: (_, i) {
                return const SizedBox(height: UiGlobal.mediumDivider);
              },
            ),
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
