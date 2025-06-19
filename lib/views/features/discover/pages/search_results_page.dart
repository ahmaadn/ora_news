import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';
import 'package:ora_news/views/widgets/inline_card.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late final TextEditingController _searchController;

  final List<Map<String, String>> _searchResults = [
    {
      'image': 'https://placehold.co/120x120/E9446A/FFFFFF/png?text=News',
      'title': 'Stock market surges to all-time low',
      'date': 'Monday, September 12',
    },
    {
      'image': 'https://placehold.co/120x120/3498db/FFFFFF/png?text=News',
      'title': 'New regulations on AI development announced',
      'date': 'Monday, September 12',
    },
    {
      'image': 'https://placehold.co/120x120/2ecc71/FFFFFF/png?text=News',
      'title': 'Local sports team wins championship',
      'date': 'Sunday, September 11',
    },
    {
      'image': 'https://placehold.co/120x120/f1c40f/FFFFFF/png?text=News',
      'title': 'The impact of climate change on agriculture',
      'date': 'Saturday, September 10',
    },
    {
      'image': 'https://placehold.co/120x120/f1c40f/FFFFFF/png?text=News',
      'title': 'The impact of climate change on agriculture',
      'date': 'Saturday, September 10',
    },
    {
      'image': 'https://placehold.co/120x120/f1c40f/FFFFFF/png?text=News',
      'title': 'The impact of climate change on agriculture',
      'date': 'Saturday, September 10',
    },
    {
      'image': 'https://placehold.co/120x120/f1c40f/FFFFFF/png?text=News',
      'title': 'The impact of climate change on agriculture',
      'date': 'Saturday, September 10',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _refineSearch(String newQuery) {
    if (newQuery.trim().isNotEmpty && newQuery != widget.query) {
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
              RichText(
                text: TextSpan(
                  style: AppTypography.headline3.copyWith(color: AppColors.textSecondary),
                  children: [
                    TextSpan(text: 'Result Search for\n', style: AppTypography.bodyText1),
                    TextSpan(
                      text: widget.query,
                      style: AppTypography.headline2.copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.s),
                child: Divider(),
              ),
              ListView.builder(
                itemCount: _searchResults.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final result = _searchResults[index];
                  return InlineCard(highlight: result);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
