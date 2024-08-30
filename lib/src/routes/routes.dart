import 'package:magic/src/presentation/pages/card_detail/card_detail.dart';
import 'package:magic/src/presentation/pages/card_list/card_list.dart';
import 'package:magic/src/presentation/pages/me/me_page.dart';
import 'package:magic/src/routes/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.me,
        path: '/',
        builder: (context, state) => const MePage(),
      ),
      GoRoute(
        name: Routes.cards,
        path: '/cards',
        builder: (context, state) => const CardList(),
      ),
      GoRoute(
        name: Routes.detail,
        path: '/detail',
        builder: (context, state) => const CardDetail(),
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(key: state.pageKey, child: const MePage());
    },
  );
  GoRouter get router => _router;
}
