import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class PageContent extends StatelessWidget {
  const PageContent({super.key, required Map<String, dynamic> page}) : _page = page;

  final Map<String, dynamic> _page;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
        Image.asset(_page['imageUrl'], height: MediaQuery.of(context).size.height * 0.35),
        AppSpacing.vsLarge,
        Text(
          _page['heading'],
          textAlign: TextAlign.left,
          style: AppTypography.title3.copyWith(color: AppColors.textPrimary),
        ),
        AppSpacing.vsMedium,
        SizedBox(
          height: 120,
          child: Text(
            _page['body'],
            textAlign: TextAlign.left,
            style: AppTypography.bodyText1.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
