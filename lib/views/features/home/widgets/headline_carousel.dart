import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';

import 'package:ora_news/views/features/home/widgets/headline_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeadlineCarousel extends StatefulWidget {
  final List<Map<String, String>> headlines;

  const HeadlineCarousel({super.key, required this.headlines});

  @override
  State<HeadlineCarousel> createState() => _HeadlineCarouselState();
}

class _HeadlineCarouselState extends State<HeadlineCarousel> {
  int _activeIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (widget.headlines.isEmpty) {
      return const SizedBox.shrink(); // Tidak menampilkan apa-apa jika tidak ada data
    }

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.headlines.length,
          itemBuilder: (context, index, realIndex) {
            final headline = widget.headlines[index];
            // Menggunakan widget HeadlineCard yang baru
            return HeadlineCard(headline: headline);
          },
          options: CarouselOptions(
            height: 350,
            // aspectRatio: 19 / 20,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _activeIndex = index;
              });
            },
          ),
        ),
        AppSpacing.vsMedium,
        AnimatedSmoothIndicator(
          activeIndex: _activeIndex,
          count: widget.headlines.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColors.primary,
            dotColor: AppColors.grey300,
            spacing: AppSpacing.s,
          ),
          onDotClicked: (index) {
            _carouselController.animateToPage(index);
          },
        ),
      ],
    );
  }
}
