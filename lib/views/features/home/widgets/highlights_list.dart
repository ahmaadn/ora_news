import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class HighlightsList extends StatelessWidget {
  final List<Map<String, String>> highlights;

  const HighlightsList({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: highlights.length,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Karena sudah di dalam SingleChildScrollView
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      itemBuilder: (context, index) {
        final highlight = highlights[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
                child: CachedNetworkImage(
                  imageUrl: highlight['image']!,
                  width: 80,
                  height: 80,
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
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.grey400,
                        ),
                      ),
                ),
              ),
              AppSpacing.hsMedium,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      highlight['title']!,
                      maxLines: 2,
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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz, color: AppColors.grey500),
              ),
            ],
          ),
        );
      },
    );
  }
}
