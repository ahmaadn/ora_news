import 'package:flutter/material.dart';
import 'package:ora_news/data/models/news_models.dart';
import 'package:ora_news/views/widgets/news_card.dart';

class TrendingList extends StatefulWidget {
  final List<NewsArticle> trendingNews;

  const TrendingList({super.key, required this.trendingNews});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.trendingNews.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final trending = widget.trendingNews[index];
        return NewsCard(trending: trending);
      },
    );
  }
}
