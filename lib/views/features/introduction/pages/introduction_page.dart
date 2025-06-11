import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/features/introduction/model/introduction_content_model.dart';
import 'package:ora_news/views/features/introduction/widgets/page_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final List<IntroductionContentModel> _pages = [
    IntroductionContentModel(
      imageUrl: 'assets/images/intro 1.png',
      heading: 'Selamat Datang di OraNews',
      body:
          'Dapatkan berita terbaru, tercepat, dan terpercaya dari seluruh penjuru Nusantar',
    ),
    IntroductionContentModel(
      imageUrl: 'assets/images/intro 2.png',
      heading: 'Berita yang Relevan, Bukan Cuma Viral',
      body:
          'Kami menyaring informasi, supaya kamu nggak kebanjiran berita palsu. Pilih topik favoritmu: politik, teknologi, budaya, utawa olahraga – kabeh ana!',
    ),
    IntroductionContentModel(
      imageUrl: 'assets/images/intro 3.png',
      heading: 'Waktumu Berharga, Bacamu Gak Perlu Lama',
      body:
          'Kami tahu kamu sibuk. Makanya, OraNews dirancang supaya kamu bisa baca berita dalam hitungan detik. Ringkas, ringan, dan enak dilihat',
    ),
  ];

  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      log('Navigate to Login Screen');
    }
  }

  void _skipOnboarding() {
    log('Skip onboarding, navigate to Home Screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          // Tombol Skip di AppBar (hanya tampil jika bukan halaman terakhir)
          if (_currentPage < _pages.length - 1)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.s),
              child: TextButton(
                onPressed: _skipOnboarding,
                child: Text(
                  'Skip',
                  style: AppTypography.headline3.copyWith(color: AppColors.textPrimary),
                ),
              ),
            )
          else
            const SizedBox.shrink(), // Tidak menampilkan apa-apa jika halaman terakhir
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.horizontalPaddingPage),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return PageContent(page: _pages[index]);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage != 0)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      ),
                    )
                  else
                    Expanded(child: AppSpacing.hsXXSmall),
                  AppSpacing.hsMedium,
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      dotWidth: AppSpacing.s,
                      dotHeight: AppSpacing.s,
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.greyMedium,
                    ),
                  ),
                  AppSpacing.hsMedium,
                  if (_currentPage < _pages.length - 1)
                    Expanded(
                      child: TextButton(
                        onPressed: _navigateToNextPage,
                        child: Icon(Icons.arrow_forward, color: AppColors.textPrimary),
                      ),
                    )
                  else
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _navigateToNextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.l,
                            vertical: AppSpacing.s + AppSpacing.xs,
                          ),
                        ),
                        child: Text(
                          _currentPage < _pages.length - 1 ? 'Selanjutnya' : 'Login',
                          style: AppTypography.button.copyWith(color: AppColors.textLight),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
