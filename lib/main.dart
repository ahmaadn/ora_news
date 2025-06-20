import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ora_news/app/config/app_route.dart';
import 'package:ora_news/data/provider/auth_provider.dart';
import 'package:ora_news/data/provider/news_public_provider.dart';
import 'package:ora_news/data/provider/user_news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsPublicProvider()),
        ChangeNotifierProvider(create: (_) => UserNewsProvider()),
      ],
      child: const OraNewsApp(),
    ),
  );
}

class OraNewsApp extends StatelessWidget {
  const OraNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'News Hive',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}
