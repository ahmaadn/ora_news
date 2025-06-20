import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';

class ImagePlaceholder {
  static Widget error(context, url, error) {
    return Container(
      color: AppColors.grey200,
      child: const Icon(Icons.image_not_supported, color: AppColors.grey400),
    );
  }

  static Widget loading(context, url) {
    return Container(
      color: AppColors.grey200,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
