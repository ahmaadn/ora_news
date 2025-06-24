import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/data/provider/news_public_provider.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';
import 'package:ora_news/views/widgets/inline_card.dart';
import 'package:ora_news/views/widgets/load_more_button.dart';
import 'package:provider/provider.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
    Future.microtask(
      () => context.read<NewsPublicProvider>().fetchNewsBySearch(widget.query),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refineSearch(String newQuery) async {
    if (newQuery.trim().isNotEmpty && newQuery != widget.query) {
      final newsProvider = Provider.of<NewsPublicProvider>(context, listen: false);
      newsProvider.addSearchHistory(newQuery);
      newsProvider.fetchNewsBySearch(newQuery);
      context.go('/search/results?q=$newQuery');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormField(
                controller: _searchController,
                hintText: 'Search',
                prefixIcon: Icons.search,
                onFieldSubmitted: _refineSearch,
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.close, color: AppColors.grey500),
                          onPressed: () {
                            _searchController.clear();

                            context.go('/search');
                          },
                        )
                        : null,
                boxSize: FormFieldSize.large,
                backgroundColor: AppColors.grey100,
              ),
              AppSpacing.vsMedium,
              Consumer<NewsPublicProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTypography.headline3.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Result Search for\n',
                              style: AppTypography.bodyText1,
                            ),
                            TextSpan(
                              text: widget.query,
                              style: AppTypography.headline2.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.s),
                        child: Divider(),
                      ),
                      ListView.builder(
                        itemCount: provider.newsBySearch.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final result = provider.newsBySearch[index];
                          return InlineCard(highlight: result);
                        },
                      ),
                      LoadMoreButton(
                        isLoading: provider.isLoadingMore,
                        onPressed: () {
                          provider.loadMoreNews(search: widget.query);
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
