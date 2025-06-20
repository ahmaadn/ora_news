import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/app/utils/app_notif.dart';
import 'package:ora_news/data/provider/user_news_provider.dart';
import 'package:ora_news/views/features/news/widgets/user_inline_card.dart';
import 'package:ora_news/views/widgets/app_button.dart';
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

  Future<void> _showDeleteConfirmationDialog(String id) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.roundedLarge),
          ),
          title: Text(
            'Konfirmasi Hapus',
            textAlign: TextAlign.center,
            style: AppTypography.headline2,
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus berita ini? Aksi ini tidak dapat dibatalkan.',
            textAlign: TextAlign.center,
            style: AppTypography.bodyText2,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(
            bottom: AppSpacing.m,
            left: AppSpacing.m,
            right: AppSpacing.m,
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    text: "Cancel",
                    backgroundColor: AppColors.grey200,
                    foregroundColor: AppColors.textPrimary,
                  ),
                ),
                AppSpacing.hsMedium,
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    text: "Confirm",
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final newsProvider = Provider.of<UserNewsProvider>(context, listen: false);
      await newsProvider.deleteNews(id);
      await newsProvider.fetchUserNews();
      AppNotif.success(context, message: 'Berita berhasil dihapus');
    }
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
                        'Total Publish News : ${provider.countNews}',
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
                              AppSpacing.vsMedium,
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      onPressed: () {},
                                      text: "Update",
                                      backgroundColor: AppColors.warning,
                                      foregroundColor: AppColors.textPrimary,
                                    ),
                                  ),
                                  AppSpacing.hsMedium,
                                  Expanded(
                                    child: PrimaryButton(
                                      onPressed:
                                          () => _showDeleteConfirmationDialog(result.id),
                                      text: "Delete",
                                      backgroundColor: AppColors.error,
                                      foregroundColor: AppColors.textLight,
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.vsSmall,
                              const Divider(),
                              AppSpacing.vsSmall,
                            ],
                          );
                        },
                      ),
                      OutlineButtonWidget(
                        onPressed: () {},
                        text: "Load More",
                        width: double.infinity,
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
