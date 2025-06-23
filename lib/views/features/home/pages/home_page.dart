import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/data/models/news_models.dart';
import 'package:ora_news/data/provider/news_public_provider.dart';
import 'package:ora_news/views/features/home/widgets/headline_carousel.dart';
import 'package:ora_news/views/features/home/widgets/highlights_list.dart';
import 'package:ora_news/views/features/home/widgets/section_header.dart';
import 'package:ora_news/views/features/home/widgets/trending_list.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';
import 'package:ora_news/views/widgets/main_app_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final allNewsCategory = CategoryNews(id: 'all', name: 'All News');

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NewsPublicProvider>().fetchHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsPublicProvider>(
      builder: (context, provider, child) {
        final displayCategories = [allNewsCategory, ...provider.categories];

        return _buildScaffold(
          provider: provider,
          displayCategories: displayCategories,
          body: _buildBodyContent(provider),
        );
      },
    );
  }

  Widget _buildBodyContent(NewsPublicProvider provider) {
    if (provider.isLoading && provider.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (provider.errorMessage != null && provider.categories.isEmpty) {
      return Center(child: Text('Error: ${provider.errorMessage}'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.vsMedium,
          HeadlineCarousel(headlines: provider.headlines),
          AppSpacing.vsLarge,
          SectionHeader(title: 'Highlights'),
          HighlightsList(highlights: provider.highlights),
          AppSpacing.vsLarge,
          SectionHeader(title: '🔥 Trending'),
          TrendingList(trendingNews: provider.trending),
          AppSpacing.vsMedium,
          _buildLoadMoreButton(provider),
          AppSpacing.vsLarge,
        ],
      ),
    );
  }

  Widget _buildScaffold({
    required NewsPublicProvider provider,
    required List<CategoryNews> displayCategories,
    required Widget body,
  }) {
    return DefaultTabController(
      length: displayCategories.length,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: AppColors.background,
                    automaticallyImplyLeading: false,
                    floating: true,
                    snap: true,
                    flexibleSpace: MainAppBar(),
                    bottom: _buildCategoryTabs(
                      provider: provider,
                      displayCategories: displayCategories,
                    ),
                  ),
                ],
            body: body,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildCategoryTabs({
    required NewsPublicProvider provider,
    required List<CategoryNews> displayCategories,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kTextTabBarHeight + AppSpacing.m),
      child: Column(
        children: [
          Divider(height: 1, color: AppColors.grey300),
          TabBar(
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textPrimary,
            labelStyle: AppTypography.button,
            unselectedLabelStyle: AppTypography.button.copyWith(
              fontWeight: AppTypography.regular,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.primary, width: 3.0),
              insets: EdgeInsets.only(left: 0, right: 0, bottom: 45),
            ),
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            onTap: (index) {
              final categoryId = displayCategories[index].id;
              if (categoryId == 'all') {
                provider.fetchHomeData();
              } else {
                provider.fetchNewsByCategory(categoryId);
              }
            },
            tabs: displayCategories.map((category) => Tab(text: category.name)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton(NewsPublicProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: PrimaryButton(
        onPressed: () {
          provider.loadMoreNews();
        },
        text: "Load More",
        width: double.infinity,
        buttonSize: CustomButtonSize.medium,
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
