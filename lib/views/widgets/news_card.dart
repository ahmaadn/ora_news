import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/app/utils/app_date_formatter.dart';
import 'package:ora_news/app/utils/image_placeholder.dart';
import 'package:ora_news/data/models/news_models.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.trending});

  final NewsArticle trending;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
            child: CachedNetworkImage(
              imageUrl:
                  trending.imageUrl ??
                  "https://placehold.co/120x120/E9446A/FFFFFF/png?text=News",
              height: 200,
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
          AppSpacing.vsMedium,
          Text(
            trending.user.name,
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          ),
          AppSpacing.vsSmall,
          Text(
            trending.title,
            maxLines: 2,
            style: AppTypography.headline3.copyWith(height: 1.4),
          ),
          AppSpacing.vsSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppDateFormatter.formatFullDate(trending.publishedAt),
                style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
              ),
              TextButton(
                onPressed: () {
                  log('Masuk Ke halaman detail news');
                  log("${GoRouter.of(context).state.name}");

                  context.pushNamed(
                    RouteNames.newsDetail,
                    pathParameters: {'id': trending.id},
                  );
                },
                child: Text(
                  'Read full coverage ->',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
