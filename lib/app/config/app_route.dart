import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/views/features/auth/pages/forget_password_page.dart';
import 'package:ora_news/views/features/auth/pages/login_page.dart';
import 'package:ora_news/views/features/auth/pages/register_page.dart';
import 'package:ora_news/views/features/discover/pages/discover_page.dart';
import 'package:ora_news/views/features/discover/pages/search_results_page.dart';
import 'package:ora_news/views/features/home/pages/home_page.dart';
import 'package:ora_news/views/features/introduction/pages/introduction_page.dart';
import 'package:ora_news/views/features/introduction/pages/splash_page.dart';
import 'package:ora_news/views/features/main/pages/main_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouteInformation<T> {
  final T? data;
  final bool maintainState;

  AppRouteInformation({this.data, this.maintainState = true});
}

class AppRouter {
  AppRouter._();

  static final AppRouter _instance = AppRouter._();

  GoRouter? _router;

  GoRouter get router {
    if (_router == null) {
      _instance._router = _initRouter();
    }
    return _router!;
  }

  static AppRouter get instance => _instance;

  factory AppRouter() {
    _instance._router = _initRouter();

    return _instance;
  }

  void go<T>(String path, {T? data}) {
    _router?.go(path, extra: AppRouteInformation<T>(data: data));
  }

  Future<T?>? push<T>(String path, {T? data}) {
    return _router?.push<T>(path, extra: AppRouteInformation<T>(data: data));
  }

  static GoRouter _initRouter() {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.splash,
          pageBuilder: (context, state) => MaterialPage(child: SplashPage()),
        ),
        GoRoute(
          path: '/introduction',
          name: RouteNames.introduction,
          pageBuilder: (context, state) => MaterialPage(child: IntroductionPage()),
        ),
        GoRoute(
          path: '/auth/signin',
          name: RouteNames.login,
          pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
        ),
        GoRoute(
          path: '/auth/signup',
          name: RouteNames.register,
          pageBuilder: (context, state) => MaterialPage(child: RegisterPage()),
        ),
        GoRoute(
          path: '/auth/forget-password',
          name: RouteNames.forgetPassword,
          pageBuilder: (context, state) => MaterialPage(child: ForgetPasswordPage()),
        ),

        StatefulShellRoute.indexedStack(
          builder:
              (context, state, navigationShell) =>
                  MainPage(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  name: RouteNames.home,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/search',
                  name: RouteNames.discover,
                  builder: (context, state) => const DiscoverPage(),
                  routes: [
                    GoRoute(
                      path: 'results',
                      builder: (context, state) {
                        final query = state.uri.queryParameters['q'] ?? '';
                        return SearchResultsPage(query: query);
                      },
                    ),
                  ],
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile/news',
                  builder: (context, state) => const DiscoverPage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const DiscoverPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
