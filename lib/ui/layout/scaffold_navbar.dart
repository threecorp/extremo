import 'dart:math';

import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavbar extends StatelessWidget {
  ScaffoldNavbar({required this.child, super.key});

  final Widget child;

  final routes = () {
    final homeRoute = HomeRoute();
    // final pokemonRoute = PokemonRoute();
    // final favoriteRoute = FavoritesRoute();

    return [
      _NavigationItem(
        go: homeRoute.go,
        location: homeRoute.location,
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: t.index,
        ),
      ),
      _NavigationItem(
        go: homeRoute.go,
        location: homeRoute.location,
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: t.index,
        ),
      ),
      // _NavigationItem(
      //   go: pokemonRoute.go,
      //   location: pokemonRoute.location,
      //   item: BottomNavigationBarItem(
      //     icon: const Icon(Icons.list),
      //     label: t.index,
      //   ),
      // ),
      // _NavigationItem(
      //   go: favoriteRoute.go,
      //   location: favoriteRoute.location,
      //   item: BottomNavigationBarItem(
      //     icon: const Icon(Icons.favorite),
      //     label: t.favorite,
      //   ),
      // ),
    ];
  }();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: routes.map((route) => route.item).toList(),
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final index = routes.lastIndexWhere(
      (route) => route.location != '/' && location.startsWith(route.location),
    );
    return max(0, index);
  }

  void _onItemTapped(int index, BuildContext context) {
    routes[index].go(context);
  }
}

class _NavigationItem {
  _NavigationItem({
    required this.go,
    required this.location,
    required this.item,
  });

  final void Function(BuildContext context) go;
  final String location;
  final BottomNavigationBarItem item;
}
