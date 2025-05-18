import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.all(UiGlobal.padding) +
                      EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom,
                      ),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: UiGlobal.mediumDivider,
                    crossAxisSpacing: UiGlobal.mediumDivider,
                    childCount: bloc.notes.length,
                    itemBuilder: (context, i) {
                      if (i >= bloc.notes.length) {
                        // bug in SliverMasonryGrid
                        return const SizedBox.shrink();
                      }
                      return Note(
                        key: ValueKey(bloc.notes[i].id),
                        bloc.notes[i],
                        onDelete:
                            () => bloc.add(HomeDeleteEvent(bloc.notes[i].id)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.go('/note/new'),
            child: const Icon(Icons.create),
          ),
        );
      },
    );
  }
}
