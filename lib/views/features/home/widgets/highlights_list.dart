import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/views/widgets/inline_card.dart';

class HighlightsList extends StatelessWidget {
  final List<Map<String, String>> highlights;

  const HighlightsList({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: highlights.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      itemBuilder: (context, index) {
        final highlight = highlights[index];
        return InlineCard(highlight: highlight);
      },
    );
  }
}
