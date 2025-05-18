part of 'main.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(key: state.pageKey),
      routes: [
        GoRoute(
          path: 'new_note',
          builder: (context, state) => NewNotePage(key: state.pageKey),
        ),
      ],
    ),
  ],
);
