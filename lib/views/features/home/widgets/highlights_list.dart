import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/data/models/news_models.dart';
import 'package:ora_news/views/widgets/inline_card.dart';

class HighlightsList extends StatefulWidget {
  final List<NewsArticle> highlights;

  const HighlightsList({super.key, required this.highlights});

  @override
  State<HighlightsList> createState() => _HighlightsListState();
}

class _HighlightsListState extends State<HighlightsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.highlights.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      itemBuilder: (context, index) {
        final highlight = widget.highlights[index];
        return InlineCard(highlight: highlight);
      },
    );
  }
}
