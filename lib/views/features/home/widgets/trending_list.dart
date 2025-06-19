import 'package:flutter/material.dart';
import 'package:ora_news/views/widgets/news_card.dart';

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
        return NewsCard(trending: trending);
      },
    );
  }
}
