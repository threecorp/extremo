import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/scaffold_navbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  usePathUrlStrategy();

  await Hive.initFlutter();
  // Hive.registerAdapter(PokemonEntityAdapter());

  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      ShellRoute(
        routes: $appRoutes,
        builder: (context, state, child) => ScaffoldNavbar(child: child),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: t.appName,
      theme: ThemeData(
        // primarySwatch: Colors.blueGrey,
        colorSchemeSeed: Colors.blueGrey,
        brightness: Brightness.light,
        fontFamily: 'Noto Sans JP',
        useMaterial3: true,
      ),
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: _router,
    );
  }
}
