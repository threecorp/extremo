import 'package:extremo/misc/logger.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/entity/extremo/extremo.dart' as extremo_entity;
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/scaffold_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  usePathUrlStrategy();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(extremo_entity.ArtifactEntityAdapter())
    ..registerAdapter(extremo_entity.ChatEntityAdapter())
    ..registerAdapter(extremo_entity.ChatMessageEntityAdapter())
    ..registerAdapter(extremo_entity.UserProfileEntityAdapter())
    ..registerAdapter(extremo_entity.UserEntityAdapter());

  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      redirect: (context, state) {
        final notifier = ref.watch(accountProvider.notifier);
        final publicPages = [Routes.loginPage, Routes.registerPage];
        final isPublic = publicPages.contains(state.matchedLocation);

        // logger.d('StateValue: ${notifier.stateValue()}');
        // logger.d('path: ${state.path}');
        // logger.d('name: ${state.name}');
        // logger.d('uri: ${state.uri}');
        // logger.d('loc: ${state.matchedLocation}');

        if (isPublic) {
          return state.matchedLocation;
        }
        if (!notifier.isLoggedIn() && !isPublic) {
          return Routes.loginPage;
        }
        if (notifier.isLoggedIn() && isPublic) {
          return Routes.rootPage;
        }

        return null;
      },
      routes: [
        ShellRoute(
          routes: $appRoutes,
          builder: (context, state, child) => ScaffoldNavbar(child: child),
        ),
      ],
    );

    return MaterialApp.router(
      title: t.appName,
      theme: ThemeData(
        useMaterial3: true,
        // primarySwatch: Colors.blueGrey,
        // colorSchemeSeed: Colors.blueGrey,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          // brightness: Brightness.light,
        ),
        fontFamily: 'Noto Sans JP',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.grey,
        ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blueGrey,
        //     foregroundColor: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        // ),
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
        //   bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
        // ),

        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFF2F2F2), // white grey
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          // helperStyle: const TextStyle(
          //   color: Colors.grey,
          //   // fontSize: 12,
          //   // fontWeight: FontWeight.normal,
          // ),
          labelStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),

        // listTileTheme: ListTileThemeData(
        //   tileColor: Colors.grey[200], // background color
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12), // radius corner
        //   ),
        //   selectedTileColor: Colors.grey[300],
        //   textColor: Colors.black,
        //   iconColor: Colors.grey,
        // ),
      ),
      supportedLocales: AppLocaleUtils.supportedLocales + FormBuilderLocalizations.supportedLocales,
      localizationsDelegates: const [
        // AppLocalizations.delegate,
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      // localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: router,
    );
  }
}
