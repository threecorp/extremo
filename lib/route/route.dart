// import 'package:extremo/ui/page/favorite.dart';
// import 'package:extremo/ui/page/extremo.dart';
// import 'package:extremo/ui/page/extremo_detail.dart';
import 'package:extremo/ui/page/artifact.dart';
import 'package:extremo/ui/page/post.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'route.g.dart';

//
// Entrypoints
// Keep paths together as constants.
//
class Route {
  static const artifactPage = '/';
  static const postPage = '/post';
  // static const extremoPage = "/extremos";
  // static const favoritePage = "/favorites";
  // static const splashPage = "/splash";
  // static const userPage = "users/:uid";
}

@TypedGoRoute<ArtifactRoute>(
  path: Route.artifactPage,
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

@TypedGoRoute<PostRoute>(
  path: Route.postPage,
  // routes: [TypedGoRoute<PostDetailRoute>(path: ':id')]
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

// @immutable
// class PostDetailRoute extends GoRouteData {
//   const PostDetailRoute({required this.id});
//   final int id;
//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) =>
//       CustomTransitionPage(
//           key: state.pageKey,
//           child: PokemonDetailPage(id: id),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//               FadeTransition(opacity: animation, child: child));
// }
