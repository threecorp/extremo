// import 'package:extremo/ui/page/favorite.dart';
// import 'package:extremo/ui/page/extremo.dart';
// import 'package:extremo/ui/page/extremo_detail.dart';
import 'package:extremo/ui/page/artifact.dart';
import 'package:extremo/ui/page/artifact_detail.dart';
import 'package:extremo/ui/page/post.dart';
import 'package:extremo/ui/page/login.dart';

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
  // static const favoritePage = "/favorites";
  // static const splashPage = "/splash";
  // static const userPage = "users/:uid";
}

@TypedGoRoute<ArtifactRoute>(
  path: Routes.artifactPage,
  routes: [TypedGoRoute<ArtifactDetailRoute>(path: ':id')],
)
@immutable
class ArtifactRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: const ArtifactPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

@immutable
class ArtifactDetailRoute extends GoRouteData {
  const ArtifactDetailRoute({required this.id});
  final int id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: ArtifactDetailPage(id: id),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<LoginRoute>(
  path: Routes.loginPage,
)
@immutable
class LoginRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<PostRoute>(
  path: Routes.rootPage,
)
@immutable
class PostRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: const PostPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}
