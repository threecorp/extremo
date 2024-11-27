// import 'package:extremo/ui/page/favorite.dart';
// import 'package:extremo/ui/page/extremo.dart';
// import 'package:extremo/ui/page/extremo_detail.dart';
import 'package:extremo/ui/page/artifact.dart';
import 'package:extremo/ui/page/artifact_detail.dart';
import 'package:extremo/ui/page/login.dart';
import 'package:extremo/ui/page/menu.dart';
import 'package:extremo/ui/page/message.dart';
import 'package:extremo/ui/page/message_detail.dart';
import 'package:extremo/ui/page/reserve.dart';
import 'package:extremo/ui/page/user.dart';
import 'package:extremo/ui/page/user_detail.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'route.g.dart';

//
// Entrypoints
// Keep paths together as constants.
//
class Routes {
  static const rootPage = '/';
  static const artifactPage = '/artifacts';
  static const loginPage = '/login';
  static const menuPage = '/menus';
  static const messagePage = '/messages';
  static const userPage = '/users';
  // static const splashPage = "/splash";
  // static const userPage = "users/:uid";
}

@TypedGoRoute<LoginRoute>(
  path: Routes.loginPage,
)
@immutable
class LoginRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<UserRoute>(
  path: Routes.userPage,
  routes: [TypedGoRoute<UserDetailRoute>(path: ':id')],
)
@immutable
class UserRoute extends GoRouteData {
  const UserRoute({
    this.$extra,
  });

  final void Function(User)? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: UserPage(onTapAction: $extra),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    );
  }
}

@immutable
class UserDetailRoute extends GoRouteData {
  const UserDetailRoute({required this.id});
  final int id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: UserDetailPage(id: id),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<MenuRoute>(
  path: Routes.menuPage,
  // routes: [TypedGoRoute<MenuDetailRoute>(path: ':id')],
)
@immutable
class MenuRoute extends GoRouteData {
  const MenuRoute({
    this.$extra,
  });

  final void Function(Menu)? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: MenuPage(onTapAction: $extra),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    );
  }
}

@TypedGoRoute<ArtifactRoute>(
  path: Routes.artifactPage,
  routes: [TypedGoRoute<ArtifactDetailRoute>(path: ':id')],
)
@immutable
class ArtifactRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ArtifactPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@immutable
class ArtifactDetailRoute extends GoRouteData {
  const ArtifactDetailRoute({required this.id});
  final int id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: ArtifactDetailPage(id: id),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<ReserveRoute>(
  path: Routes.rootPage,
)
@immutable
class ReserveRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ReservePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<MessageRoute>(
  path: Routes.messagePage,
  routes: [TypedGoRoute<MessageDetailRoute>(path: ':id')],
)
@immutable
class MessageRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MessagePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@immutable
class MessageDetailRoute extends GoRouteData {
  const MessageDetailRoute({required this.id});
  final int id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: MessageDetailPage(id: id),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}
