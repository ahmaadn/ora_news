import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
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
                      RichText(
                        text: TextSpan(
                          style: AppTypography.headline3.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Total Publish News : ${provider.news.length.toString()}',
                              style: AppTypography.title3,
                            ),
                          ],
                        ),
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
                          return UserInlineCard(article: result);
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
    );
  }
}
