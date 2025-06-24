import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({super.key, required this.isLoading, required this.onPressed});

  final bool isLoading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
              ),
              SizedBox(width: 8),
              Text("Loading", style: TextStyle(color: AppColors.grey600, fontSize: 14)),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: PrimaryButton(
        onPressed: onPressed,
        text: "Load More",
        width: double.infinity,
        buttonSize: CustomButtonSize.medium,
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
