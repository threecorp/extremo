// import 'package:extremo/ui/page/extremo.dart';
// import 'package:extremo/ui/page/extremo_detail.dart';
// import 'package:extremo/ui/page/favorite.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/ui/page/artifact.dart';
import 'package:extremo/ui/page/artifact_detail.dart';
import 'package:extremo/ui/page/chat.dart';
import 'package:extremo/ui/page/chat_message.dart';
import 'package:extremo/ui/page/login.dart';
import 'package:extremo/ui/page/team.dart';
import 'package:extremo/ui/page/service.dart';
import 'package:extremo/ui/page/register.dart';
import 'package:extremo/ui/page/reserve.dart';
import 'package:extremo/ui/page/tenant.dart';
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
  static const registerPage = '/register';
  static const teamPage = '/teams';
  static const servicePage = '/services';
  static const messagePage = '/messages';
  static const userPage = '/users';
  static const tenantPage = '/tenants';
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

@TypedGoRoute<RegisterRoute>(
  path: Routes.registerPage,
)
@immutable
class RegisterRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RegisterPage(),
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

  final void Function(UserModel)? $extra;

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

@TypedGoRoute<TeamRoute>(
  path: Routes.teamPage,
  // routes: [TypedGoRoute<TeamDetailRoute>(path: ':id')],
)
@immutable
class TeamRoute extends GoRouteData {
  const TeamRoute({
    this.$extra,
  });

  final void Function(TeamModel)? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: TeamPage(onTapAction: $extra),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    );
  }
}

@TypedGoRoute<ServiceRoute>(
  path: Routes.servicePage,
  // routes: [TypedGoRoute<ServiceDetailRoute>(path: ':id')],
)
@immutable
class ServiceRoute extends GoRouteData {
  const ServiceRoute({
    this.$extra,
  });

  final void Function(ServiceModel)? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: ServicePage(onTapAction: $extra),
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

@TypedGoRoute<ChatRoute>(
  path: Routes.messagePage,
  routes: [TypedGoRoute<ChatMessageRoute>(path: ':id')],
)
@immutable
class ChatRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ChatPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@immutable
class ChatMessageRoute extends GoRouteData {
  const ChatMessageRoute({required this.id});
  final int id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: ChatMessagePage(id: id),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<TenantRoute>(
  path: Routes.tenantPage,
  // routes: [TypedGoRoute<TenantDetailRoute>(path: ':id')],
)
@immutable
class TenantRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: const TenantPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    );
  }
}
// @immutable
// class TenantDetailRoute extends GoRouteData {
//   const TenantDetailRoute({required this.id});
//   final int id;
//
//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
//         key: state.pageKey,
//         child: TenantDetailPage(id: id),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
//       );
// }
