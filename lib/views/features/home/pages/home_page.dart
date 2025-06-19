import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/features/home/widgets/headline_carousel.dart';
import 'package:ora_news/views/features/home/widgets/highlights_list.dart';
import 'package:ora_news/views/features/home/widgets/section_header.dart';
import 'package:ora_news/views/features/home/widgets/trending_list.dart';
import 'package:ora_news/views/widgets/custom_button.dart';
import 'package:ora_news/views/widgets/main_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  final List<Map<String, String>> _headlinesData = [
    {
      'image': 'https://picsum.photos/600/400?random=1',
      'title': 'Tech giant announces major investment in renewable energy',
      'source': 'BBC News',
      'date': "11",
      'time_ago': '2 hours ago',
    },
    {
      'image': 'https://picsum.photos/600/400?random=2',
      'title': 'New Breakthrough in AI could change the future of medicine',
      'source': 'Ora News',
    },
    {
      'image': 'https://picsum.photos/600/400?random=3',
      'title': 'Exploring the depths of the ocean: New species discovered',
      'source': 'Nat Geo',
    },
  ];

  final List<Map<String, String>> _highlightsData = List.generate(
    4,
    (index) => {
      'image': 'https://picsum.photos/600/400?random=${index + 1}',
      'title': 'Stock market surges to all-time low after announcement',
      'source': 'Reuters',
      'date': 'September 20',
    },
  );

  final List<Map<String, String>> _trendingNewsData = List.generate(
    3,
    (index) => {
      'image': 'https://picsum.photos/600/400?random=${index + 1}',
      'title': 'Global trade agreements shift as new tariffs take effect',
      'source': 'Associated Press',
    },
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.background,
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                flexibleSpace: MainAppBar(),
                bottom: _buildCategoryTabs(),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.vsMedium,
                HeadlineCarousel(headlines: _headlinesData),
                AppSpacing.vsLarge,
                SectionHeader(title: 'Highlights'),
                HighlightsList(highlights: _highlightsData),
                AppSpacing.vsLarge,
                SectionHeader(title: '🔥 Trending'),
                TrendingList(trendingNews: _trendingNewsData),
                AppSpacing.vsMedium,
                _buildLoadMoreButton(),
                AppSpacing.vsLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildCategoryTabs() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kTextTabBarHeight + AppSpacing.m),
      child: Column(
        children: [
          Divider(height: 1, color: AppColors.grey300),
          TabBar(
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
            tabs: const [
              Tab(text: 'Trending'),
              Tab(text: 'Challenges'),
              Tab(text: 'For You'),
              Tab(text: 'Olahraga'),
              Tab(text: 'Politik'),
              Tab(text: 'Pendidikan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: CustomButton(
        buttonType: CustomButtonType.outline,
        onPressed: () {},
        text: 'Load More',
        width: double.infinity,
        buttonSize: CustomButtonSize.large,
      ),
    );
  }
}
