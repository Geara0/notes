part of 'home_bloc.dart';

@immutable
sealed class _HomeEvent {}

class HomeGetNotesEvent extends _HomeEvent {
  HomeGetNotesEvent({this.start, this.count = 50});

  final int? start;
  final int count;
}

class HomeRefreshEvent extends _HomeEvent {}

class HomeDeleteEvent extends _HomeEvent {
  HomeDeleteEvent(this.id);

  final int id;
}
