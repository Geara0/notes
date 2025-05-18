import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/pages/home/home_page.dart';
import 'package:notes/pages/new_note/new_note_page.dart';
import 'package:notes/services/db_service.dart';

part 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
    );
  }
}
