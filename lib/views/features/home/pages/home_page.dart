import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:ora_news/views/widgets/load_more_button.dart';
import 'package:ora_news/views/widgets/main_app_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final allNewsCategory = CategoryNews(id: 'all', name: 'All News');

  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isTabControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsPublicProvider>().fetchHomeData().then((_) {
        if (mounted) {
          _initializeTabController();
        }
      }),
    );
  }

  void _initializeTabController() {
    final provider = context.read<NewsPublicProvider>();
    final categoryCount = provider.categories.length + 1;

    if (_isTabControllerInitialized) {
      _tabController.removeListener(_handleTabSelection);
    }

    _tabController = TabController(length: categoryCount, vsync: this);
    _tabController.addListener(_handleTabSelection);

    setState(() {
      _isTabControllerInitialized = true;
    });
  }

  Future<void> _handleTabSelection() async {
    if (_tabController.indexIsChanging) return;

    final provider = context.read<NewsPublicProvider>();
    final displayCategories = [allNewsCategory, ...provider.categories];
    final categoryId = displayCategories[_tabController.index].id;

    fetchData() {
      if (mounted) {
        if (categoryId == 'all') {
          context.read<NewsPublicProvider>().fetchHomeData();
        } else {
          context.read<NewsPublicProvider>().fetchNewsByCategory(categoryId);
        }
      }
    }

    // Scroll NestedScrollView ke atas.
    if (_scrollController.hasClients) {
      _scrollController
          .animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          )
          .whenComplete(() {
            fetchData();
          });
    } else {
      fetchData();
    }
  }

  // Fungsi untuk menangani logika pull-to-refresh
  Future<void> _onRefresh() async {
    final provider = context.read<NewsPublicProvider>();
    final displayCategories = [allNewsCategory, ...provider.categories];

    if (_tabController.index < displayCategories.length) {
      final categoryId = displayCategories[_tabController.index].id;
      if (categoryId == 'all') {
        await provider.fetchHomeData();
      } else {
        await provider.fetchNewsByCategory(categoryId, forceRefresh: true);
      }
    }
  }

  @override
  void dispose() {
    if (_isTabControllerInitialized) {
      _tabController.removeListener(_handleTabSelection);
      _tabController.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsPublicProvider>(
      builder: (context, provider, child) {
        if (!_isTabControllerInitialized) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
          );
        }

        final displayCategories = [allNewsCategory, ...provider.categories];
        if (_tabController.length != displayCategories.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _initializeTabController();
          });
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: NestedScrollView(
              controller: _scrollController,
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
              body: TabBarView(
                controller: _tabController,
                children:
                    displayCategories.map((category) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.primary,
                        backgroundColor: AppColors.background,
                        child:
                            displayCategories[_tabController.index].id == category.id
                                ? _buildBodyContent(provider: provider, category: category)
                                : Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyContent({
    required NewsPublicProvider provider,
    required CategoryNews category,
  }) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (provider.errorMessage != null && provider.categories.isEmpty) {
      return Center(child: Text('Error: ${provider.errorMessage}'));
    }

    return CustomScrollView(
      key: PageStorageKey<String>(provider.selectedCategoryId ?? 'all'),
      slivers: [
        SliverToBoxAdapter(
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
              LoadMoreButton(
                isLoading: provider.isLoadingMore,
                onPressed: () {
                  provider.loadMoreNews();
                },
              ),
              AppSpacing.vsLarge,
            ],
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildCategoryTabs({
    required NewsPublicProvider provider,
    required List<CategoryNews> displayCategories,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kTextTabBarHeight + AppSpacing.m),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.grey300, width: 1.0)),
          color: AppColors.background,
        ),
        child: TabBar(
          controller: _tabController,
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
          tabs: displayCategories.map((category) => Tab(text: category.name)).toList(),
        ),
      ),
    );
  }
}
