import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/views/features/auth/pages/forget_password_page.dart';
import 'package:ora_news/views/features/auth/pages/signin_page.dart';
import 'package:ora_news/views/features/auth/pages/signup_page.dart';
import 'package:ora_news/views/features/introduction/pages/introduction_page.dart';
import 'package:ora_news/views/features/introduction/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static final AppRouter _instance = AppRouter._();

  static AppRouter get instance => _instance;

  factory AppRouter() {
    _instance.goRouter = goRouterSetup();

    return _instance;
  }

  GoRouter? goRouter;

  static GoRouter goRouterSetup() {
    return GoRouter(
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
          pageBuilder: (context, state) => MaterialPage(child: SignInPage()),
        ),
        GoRoute(
          path: '/auth/signup',
          name: RouteNames.register,
          pageBuilder: (context, state) => MaterialPage(child: SignUpPage()),
        ),
        GoRoute(
          path: '/auth/forget-password',
          name: RouteNames.forgetPassword,
          pageBuilder: (context, state) => MaterialPage(child: ForgetPasswordPage()),
        ),
      ],
    );
  }
}
