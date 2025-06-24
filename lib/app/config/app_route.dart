import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/data/models/user_models.dart';
import 'package:ora_news/data/provider/auth_provider.dart';
import 'package:ora_news/views/features/auth/pages/forget_password_page.dart';
import 'package:ora_news/views/features/auth/pages/login_page.dart';
import 'package:ora_news/views/features/auth/pages/register_page.dart';
import 'package:ora_news/views/features/discover/pages/discover_page.dart';
import 'package:ora_news/views/features/discover/pages/search_results_page.dart';
import 'package:ora_news/views/features/home/pages/home_page.dart';
import 'package:ora_news/views/features/introduction/pages/introduction_page.dart';
import 'package:ora_news/views/features/introduction/pages/splash_page.dart';
import 'package:ora_news/views/features/main/pages/main_page.dart';
import 'package:ora_news/views/features/news/pages/add_update_news_page.dart';
import 'package:ora_news/views/features/news/pages/list_my_news_page.dart';
import 'package:ora_news/views/features/news/pages/news_detail_page.dart';
import 'package:ora_news/views/features/profile/pages/profile_page.dart';
import 'package:provider/provider.dart';

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

        GoRoute(
          path: '/news-detail/:id',
          name: RouteNames.newsDetail,
          builder: (context, state) {
            final newsId = state.pathParameters['id'];

            if (newsId != null) {
              return NewsDetailPage(newsId: newsId);
            } else {
              // Tampilan fallback jika tidak ada artikel yang diteruskan
              return const Scaffold(body: Center(child: Text("Article not found.")));
            }
          },
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
                  name: RouteNames.myNews,
                  builder: (context, state) => const ListMyNewsPage(),
                  redirect: (context, state) {
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    final isLoggedIn = authProvider.isLoggedIn;
                    if (!isLoggedIn) {
                      return '/auth/signin';
                    }
                    return null;
                  },
                  routes: [
                    GoRoute(
                      path: 'create',
                      name: RouteNames.createNews,
                      builder: (context, state) => const AddUpdateNewsPage(),
                    ),
                    GoRoute(
                      path: 'update/:id',
                      name: RouteNames.updateNews,
                      builder: (context, state) {
                        final newsId = state.pathParameters['id'];
                        final info = state.extra as AppRouteInformation<MyNewsArticle>?;
                        final article = info?.data;

                        if (newsId != null) {
                          return AddUpdateNewsPage(newsData: article);
                        } else {
                          return const Scaffold(
                            body: Center(child: Text("Article not found.")),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  redirect: (context, state) {
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    final isLoggedIn = authProvider.isLoggedIn;
                    if (!isLoggedIn) {
                      return '/auth/signin';
                    }
                    return null;
                  },
                  builder: (context, state) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
