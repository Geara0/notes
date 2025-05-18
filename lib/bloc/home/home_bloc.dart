import 'dart:async';

import 'package:bloc/bloc.dart';
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
          (events, mapper) => events
              .debounceTime(const Duration(milliseconds: 300))
              .flatMap(mapper),
    );
    on<HomeRefreshEvent>(_refresh);
    on<HomeDeleteEvent>(_delete);

    _notesStream = DBService.notesStream();
    _notesStream.listen(_streamUpdate);
    add(HomeRefreshEvent());
  }

  late final Stream<void> _notesStream;
  bool _ignoreStream = false;

  final notes = <NoteDto>[];

  FutureOr<void> _getNotes(
    HomeGetNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final res = await DBService.getNotes(
      event.start ?? notes.length,
      event.count,
    );

    notes.addAll(res.map(NoteDto.fromDao));

    emit(HomeBuildState());
  }

  FutureOr<void> _refresh(HomeRefreshEvent event, Emitter<HomeState> emit) {
    notes.clear();
    add(HomeGetNotesEvent(start: 0));
  }

  void _streamUpdate(void event) {
    if (_ignoreStream) return;
    add(HomeRefreshEvent());
  }

  FutureOr<void> _delete(HomeDeleteEvent event, Emitter<HomeState> emit) async {
    final index = notes.indexWhere((e) => e.id == event.id);
    notes.removeAt(index);

    _ignoreStream = true;
    await DBService.deleteNote(event.id);
    _ignoreStream = false;

    emit(HomeBuildState());
  }
}
