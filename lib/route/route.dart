// import 'package:extremo/ui/page/favorite.dart';
// import 'package:extremo/ui/page/extremo.dart';
// import 'package:extremo/ui/page/extremo_detail.dart';
import 'package:extremo/ui/page/home.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'route.g.dart';

//
// Entrypoints
// Keep paths together as constants.
//
class Route {
  static const homePage = '/';
  // static const extremoPage = "/extremos";
  // static const favoritePage = "/favorites";
  // static const splashPage = "/splash";
  // static const userPage = "users/:uid";
}

@TypedGoRoute<HomeRoute>(
  path: Route.homePage,
)
@immutable
class HomeRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(title: Route.homePage),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}
