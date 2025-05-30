import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_theme.dart';

void main() {
  runApp(const OraNewsApp());
}

class OraNewsApp extends StatelessWidget {
  const OraNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ora News',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Ora News'), backgroundColor: AppColors.background),
        body: Center(child: Text('Selamat Datang!')),
      ),
    );
  }
}
