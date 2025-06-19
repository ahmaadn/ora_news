import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/utils/image_placeholder.dart';
import 'package:ora_news/data/models/news_models.dart';

class InlineCard extends StatelessWidget {
  const InlineCard({super.key, required this.highlight});

  final NewsArticle highlight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('Masuk Ke halaman detail news');
        context.push('/news-detail/${highlight.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
              child: CachedNetworkImage(
                imageUrl:
                    highlight.imageUrl ??
                    "https://placehold.co/120x120/E9446A/FFFFFF/png?text=News",
                width: 100,
                height: 100,
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
            AppSpacing.hsMedium,
            Expanded(
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      highlight.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.subtitle1.copyWith(height: 1.4),
                    ),
                    AppSpacing.vsSmall,
                    Text(
                      '${highlight.user.name} • ${highlight.publishedAt}',
                      style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
