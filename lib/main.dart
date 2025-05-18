import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/global_variables/global_variables.dart';
import 'package:notes/pages/home/home_page.dart';
import 'package:notes/pages/note/note_page.dart';
import 'package:notes/services/db_service.dart';

part 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([EasyLocalization.ensureInitialized(), DBService.setup()]);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ru')],
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      routerConfig: _router,
      themeMode: ThemeMode.system,
      darkTheme: _buildTheme(ThemeData.dark()),
      theme: _buildTheme(ThemeData.light()),
    );
  }
}

ThemeData _buildTheme(ThemeData theme) {
  return theme.copyWith(
    cardTheme: const CardTheme(margin: EdgeInsets.zero),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(UiGlobal.inputRadius)),
      ),
    ),
  );
}
