import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/features/introduction/model/introduction_content_model.dart';

class PageContent extends StatelessWidget {
  const PageContent({super.key, required IntroductionContentModel page}) : _page = page;

  final IntroductionContentModel _page;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
        Image.asset(_page.imageUrl, height: MediaQuery.of(context).size.height * 0.35),
        AppSpacing.vsLarge,
        SizedBox(
          height: 70,
          child: Text(
            _page.heading,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppTypography.title3.copyWith(color: AppColors.textPrimary),
          ),
        ),
        AppSpacing.vsMedium,
        SizedBox(
          height: 120,
          child: Text(
            _page.body,
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
