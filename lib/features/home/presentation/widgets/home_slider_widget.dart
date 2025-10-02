import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/features/home/data/model/home_page_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeSliderWidget extends StatelessWidget {
  final SliderModel slider;
  const HomeSliderWidget({super.key, required this.slider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.95),
        itemCount: slider.slides.length,
        itemBuilder: (context, index) {
          final slide = slider.slides[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10.8,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.flickr(
                      leftDotColor: AppColors.primary,
                      rightDotColor: AppColors.secondary,
                      size: 30,
                    ),
                  ),
                  imageUrl: slide.image.url,
                  fit: BoxFit.cover,
                  width: 350,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
