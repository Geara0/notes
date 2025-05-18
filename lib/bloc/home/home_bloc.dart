import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:notes/dto/note/note_dto.dart';
import 'package:notes/services/db_service.dart';
import 'package:rxdart/rxdart.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<_HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetNotesEvent>(
      _getNotes,
      transformer:
          (events, mapper) =>
              events.debounceTime(Duration(milliseconds: 300)).flatMap(mapper),
    );
    on<HomeRefreshEvent>(_refresh);

    add(HomeRefreshEvent());
  }

  final notes = <NoteDto>[];

  FutureOr<void> _getNotes(
    HomeGetNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final res =
        await DBService.db.noteDtos
            .where()
            .sortByTimeDesc()
            .offset(event.start)
            .limit(event.count)
            .findAll();

    notes.addAll(res);

    emit(HomeBuildState());
  }

  FutureOr<void> _refresh(HomeRefreshEvent event, Emitter<HomeState> emit) {
    notes.clear();
    add(HomeGetNotesEvent(start: 0));
  }
}
