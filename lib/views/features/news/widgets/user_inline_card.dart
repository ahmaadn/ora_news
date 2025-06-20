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
import 'package:ora_news/data/models/user_models.dart';

class UserInlineCard extends StatefulWidget {
  final MyNewsArticle article;
  const UserInlineCard({super.key, required this.article});

  @override
  State<UserInlineCard> createState() => _UserInlineCardState();
}

class _UserInlineCardState extends State<UserInlineCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('Masuk Ke halaman detail news');
        log("${GoRouter.of(context).state.name}");

        context.goNamed(RouteNames.newsDetail, pathParameters: {'id': widget.article.id});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
              child: CachedNetworkImage(
                imageUrl:
                    widget.article.imageUrl ??
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
                      widget.article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.subtitle1.copyWith(height: 1.4),
                    ),
                    AppSpacing.vsSmall,
                    Text(
                      AppDateFormatter.formatTimeAgo(widget.article.publishedAt),
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
