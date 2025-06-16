import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class TrendingList extends StatelessWidget {
  final List<Map<String, String>> trendingNews;

  const TrendingList({super.key, required this.trendingNews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trendingNews.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final trending = trendingNews[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
                child: Image.network(
                  trending['image']!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              AppSpacing.vsMedium,
              Text(
                trending['title']!,
                style: AppTypography.headline3.copyWith(height: 1.4),
              ),
              AppSpacing.vsSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    trending['source']!,
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () {},
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
      },
    );
  }
}
