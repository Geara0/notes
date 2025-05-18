part of 'main.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(key: state.pageKey),
      routes: [
        GoRoute(
          path: 'note/:id',
          builder: (context, state) {
            final stringId = state.pathParameters['id'];
            final id = stringId != null ? int.tryParse(stringId) : null;
            return NotePage(key: state.pageKey, id: id);
          },
        ),
      ],
    ),
  ],
);
