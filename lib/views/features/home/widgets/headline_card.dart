import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class HeadlineCard extends StatelessWidget {
  final Map<String, String> headline;

  const HeadlineCard({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    // Memastikan data yang diperlukan tidak null, dengan nilai default jika null
    final imageUrl =
        headline['image'] ?? 'https://placehold.co/600x400/grey/white?text=No+Image';
    final title = headline['title'] ?? 'No Title Available';
    final date = headline['date'] ?? '';
    final timeAgo = headline['time_ago'] ?? '';

    return Container(
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
              placeholder:
                  (context, url) => Container(
                    color: AppColors.grey200,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    color: AppColors.grey200,
                    child: const Icon(Icons.image_not_supported, color: AppColors.grey400),
                  ),
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
                        date,
                        style: AppTypography.caption.copyWith(color: AppColors.grey300),
                      ),
                      Text(
                        timeAgo,
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
    );
  }
}
