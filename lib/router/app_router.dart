import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../blocs/authentication_bloc.dart';
import '../data/books.dart';
import '../model/book.dart';
import '../pages/book_detail_page.dart';
import '../pages/book_list_page.dart';
import '../pages/home_shell.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';

// create a Listenable from the stream of the AuthenticationBloc
class StreamListenable extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  StreamListenable(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/byAuthor',

    // when the login status changes, re-execute the redirect
    refreshListenable: StreamListenable(authBloc.stream),

    // when navigating or refreshing, check the redirect
    redirect: (context, state) {
      final loggedIn = authBloc.state.isLoggedIn;
      final onLoginPage = state.uri.path == '/login';

      if (loggedIn && onLoginPage) return '/byAuthor';
      if (!loggedIn && !onLoginPage) return '/login';
      return null; // not redirecting
    },

    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        // when visiting "/" itself, redirect to /byAuthor; when visiting its subpaths, do nothing
        redirect: (context, state) =>
            state.uri.path == '/' ? '/byAuthor' : null,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => HomeShell(child: child),
            routes: [
              GoRoute(
                path: 'byAuthor',
                name: 'byAuthor',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: BookListPage(sortType: SortType.author),
                ),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: 'byAuthorDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        BookDetailPage(book: state.extra as Book?),
                  ),
                ],
              ),
              GoRoute(
                path: 'byTitle',
                name: 'byTitle',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: BookListPage(sortType: SortType.title),
                ),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: 'byTitleDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        BookDetailPage(book: state.extra as Book?),
                  ),
                ],
              ),
              GoRoute(
                path: 'profile',
                name: 'profile',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}