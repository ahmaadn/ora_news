import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/data/provider/news_public_provider.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  void _performSearch(String query) {
    Provider.of<NewsPublicProvider>(context, listen: false).addSearchHistory(query);
    context.go('/search/results?q=$query');
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            children: [
              CustomFormField(
                controller: _searchController,
                hintText: 'Search',
                prefixIcon: Icons.search,
                onFieldSubmitted: _performSearch,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.grey500),
                  onPressed: _clearSearch,
                ),
                boxSize: FormFieldSize.large,
              ),
              Consumer<NewsPublicProvider>(
                builder: (context, provider, child) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
                      itemCount: provider.recentSearches.length,
                      itemBuilder: (context, index) {
                        final searchTerm = provider.recentSearches[index];
                        return ListTile(
                          contentPadding: EdgeInsets.only(left: AppSpacing.s),
                          leading: const Icon(Icons.history, color: AppColors.grey500),
                          title: Text(
                            searchTerm,
                            style: AppTypography.bodyText1.copyWith(
                              fontWeight: AppTypography.medium,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: AppColors.grey500),
                            onPressed: () => provider.removeSearchHistory(index),
                          ),
                          onTap: () {
                            log('Searching for: $searchTerm');
                            _searchController.text = searchTerm;
                            context.go('/search/results?q=$searchTerm');
                          },
                        );
                      },
                    ),
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
