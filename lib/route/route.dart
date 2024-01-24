// import 'package:extremo/ui/page/favorite.dart';
// import 'package:extremo/ui/page/extremo.dart';
// import 'package:extremo/ui/page/extremo_detail.dart';
import 'package:extremo/ui/page/artifact.dart';
import 'package:extremo/ui/page/artifact_detail.dart';
import 'package:extremo/ui/page/post.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'route.g.dart';

//
// Entrypoints
// Keep paths together as constants.
//
class Route {
  static const postPage = '/';
  static const artifactPage = '/artifacts';
  // static const extremoPage = "/extremos";
  // static const favoritePage = "/favorites";
  // static const splashPage = "/splash";
  // static const userPage = "users/:uid";
}

@TypedGoRoute<ArtifactRoute>(
  path: Route.artifactPage,
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

@TypedGoRoute<PostRoute>(
  path: Route.postPage,
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
