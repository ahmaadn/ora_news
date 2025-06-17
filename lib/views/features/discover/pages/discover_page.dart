import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  final List<String> _recentSearches = [
    'mortgage interest rate',
    'soccer match result',
    'rock band comeback',
    'latest tech news',
    'flutter best practices',
  ];

  void _removeSearchHistory(int index) {
    setState(() {
      _recentSearches.removeAt(index);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    FocusScope.of(context).unfocus();

    if (!_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
      });
    }

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
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
                  itemCount: _recentSearches.length,
                  itemBuilder: (context, index) {
                    final searchTerm = _recentSearches[index];
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
                        onPressed: () => _removeSearchHistory(index),
                      ),
                      onTap: () {
                        log('Searching for: $searchTerm');
                        _searchController.text = searchTerm;
                        _performSearch(searchTerm);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
