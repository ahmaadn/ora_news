import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/utils/image_placeholder.dart';

class InlineCard extends StatelessWidget {
  const InlineCard({super.key, required this.highlight});

  final Map<String, String> highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
            child: CachedNetworkImage(
              imageUrl: highlight['image']!,
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
                    highlight['title']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.subtitle1.copyWith(height: 1.4),
                  ),
                  AppSpacing.vsSmall,
                  Text(
                    '${highlight['source']} • ${highlight['date']}',
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
