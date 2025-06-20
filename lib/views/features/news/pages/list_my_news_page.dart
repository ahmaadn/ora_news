import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/data/provider/user_news_provider.dart';
import 'package:ora_news/views/features/news/widgets/user_inline_card.dart';
import 'package:provider/provider.dart';

class ListMyNewsPage extends StatefulWidget {
  const ListMyNewsPage({super.key});

  @override
  State<ListMyNewsPage> createState() => _ListMyNewsPageState();
}

class _ListMyNewsPageState extends State<ListMyNewsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserNewsProvider>().fetchUserNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: BackButton(
          color: AppColors.textPrimary,
          onPressed: () {
            context.goNamed(RouteNames.home);
          },
        ),
        title: Text(
          'Publish News',
          style: AppTypography.headline2.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserNewsProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Publish News : ${provider.news.length.toString()}',
                        style: AppTypography.headline2,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.s),
                        child: Divider(),
                      ),
                      ListView.builder(
                        itemCount: provider.news.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final result = provider.news[index];
                          return Column(
                            children: [
                              UserInlineCard(article: result),
                              AppSpacing.vsSmall,
                              const Divider(),
                              AppSpacing.vsSmall,
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log('Add new news');
        },
        backgroundColor: AppColors.success,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.textLight),
      ),
    );
  }
}
