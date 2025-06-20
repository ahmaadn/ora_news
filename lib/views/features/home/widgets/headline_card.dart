import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/app/utils/image_placeholder.dart';
import 'package:ora_news/data/models/news_models.dart';

class HeadlineCard extends StatelessWidget {
  final NewsArticle headline;

  const HeadlineCard({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        headline.imageUrl ?? 'https://placehold.co/600x400/grey/white?text=No+Image';
    final title = headline.title;
    final date =
        '${headline.publishedAt.day.toString().padLeft(2, '0')}/${headline.publishedAt.month.toString().padLeft(2, '0')}' ??
        '';
    final source = "By ${headline.user.name}";

    return GestureDetector(
      onTap: () {
        log('Masuk Ke halaman detail news');
        log("${GoRouter.of(context).state.name}");

        context.goNamed(RouteNames.newsDetail, pathParameters: {'id': headline.id});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.roundedXLarge),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
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
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withValues(alpha: .8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: AppSpacing.m,
                left: AppSpacing.m,
                right: AppSpacing.m,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.headline1.copyWith(color: AppColors.textLight),
                    ),
                    AppSpacing.vsSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          source,
                          style: AppTypography.caption.copyWith(color: AppColors.grey300),
                        ),
                        Text(
                          date,
                          style: AppTypography.caption.copyWith(color: AppColors.grey300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
