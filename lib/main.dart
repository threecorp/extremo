import 'package:extremo/io/auth/account.dart';
import 'package:extremo/io/entity/extremo/extremo.dart' as extremo_entity;
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/scaffold_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  usePathUrlStrategy();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(extremo_entity.UserEntityAdapter())
    ..registerAdapter(extremo_entity.ArtifactEntityAdapter());

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
        // final account = ref.watch(accountProvider);
        final notifier = ref.watch(accountProvider.notifier);
        final loggingIn = state.path == Routes.loginPage;

        if (!notifier.isLoggedIn() && !loggingIn) {
          return Routes.loginPage;
        }
        if (notifier.isLoggedIn() && loggingIn) {
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
        // primarySwatch: Colors.blueGrey,
        colorSchemeSeed: Colors.blueGrey,
        brightness: Brightness.light,
        fontFamily: 'Noto Sans JP',
        useMaterial3: true,
      ),
      supportedLocales: AppLocaleUtils.supportedLocales +
          FormBuilderLocalizations.supportedLocales,
      localizationsDelegates: const [
        // AppLocalizations.delegate,
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      // localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: router,
    );
  }
}
