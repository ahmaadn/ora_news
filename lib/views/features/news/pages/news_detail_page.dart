import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/utils/image_placeholder.dart' show ImagePlaceholder;
import 'package:ora_news/data/models/news_models.dart';
import 'package:ora_news/data/provider/news_public_provider.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatefulWidget {
  final String newsId;

  const NewsDetailPage({super.key, required this.newsId});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late NewsArticle article;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsPublicProvider>().fetchDetailNews(widget.newsId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: Text("Article Details", style: AppTypography.title3),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: AppColors.black),
          ),
        ],
      ),
      body: Consumer<NewsPublicProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          if (provider.newsArticleDetailShow == null) {
            return Center(child: Text('Terjadi Kesalahan'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.vsMedium,
                OutlineButtonWidget(
                  onPressed: () {},
                  text: provider.newsArticleDetailShow?.category.name.toUpperCase(),
                ),
                AppSpacing.vsMedium,

                Text(
                  provider.newsArticleDetailShow?.title ?? "News Title",
                  style: AppTypography.title3.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.m),

                // Author and Bookmark
                Row(
                  children: [
                    Text(
                      'By ${provider.newsArticleDetailShow?.user.name} on ${provider.newsArticleDetailShow?.publishedAt.toString()}',
                      style: AppTypography.caption.copyWith(color: AppColors.grey),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border, color: AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.m),

                // Main Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:
                        provider.newsArticleDetailShow?.imageUrl ??
                        "https://placehold.co/120x120/E9446A/FFFFFF/png?text=News",

                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageBuilder:
                        (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                    placeholder: ImagePlaceholder.loading,
                    errorWidget: ImagePlaceholder.error,
                  ),
                ),
                AppSpacing.vsSmall,

                // Image Caption (Placeholder)
                Text(
                  provider.newsArticleDetailShow?.title ?? "News Title",
                  style: AppTypography.bodyText1.copyWith(color: AppColors.grey),
                ),
                AppSpacing.vsLarge,

                // Article Content
                Text(
                  provider.newsArticleDetailShow?.content ?? "News Content",
                  style: AppTypography.bodyText2.copyWith(
                    height: 1.5,
                  ), // Tinggi baris untuk keterbacaan
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }
}
