import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Row(
        children: [
          Expanded(
            child: Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 28),
                Text("Ora News", style: AppTypography.title3),
              ],
            ),
          ),
          AppSpacing.hsMedium,
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://placehold.co/100x100/E9446A/FFFFFF/png?text=A',
            ),
          ),
        ],
      ),
    );
  }
}
