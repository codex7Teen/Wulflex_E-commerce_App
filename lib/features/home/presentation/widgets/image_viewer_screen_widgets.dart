import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/core/config/app_colors.dart';

class ImageViewerScreenWidgets {
  static Widget buildFullsizeImage(BuildContext context, List<String> imageUrls,
      PageController pageController, ValueChanged onPageChanged) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            imageUrls[index],
          ),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: imageUrls[index]),
        );
      },
      itemCount: imageUrls.length,
      pageController: pageController,
      onPageChanged: onPageChanged,
      loadingBuilder: (context, event) => Center(
        child: CircularProgressIndicator(
          value: event == null
              ? 0
              : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
        ),
      ),
    );
  }

  static Widget buildCloseButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  static Widget buildDottedPageIndicator(
      PageController pageController, List<String> imageUrls) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: SmoothPageIndicator(
          controller: pageController,
          count: imageUrls.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.greenThemeColor,
            dotColor: Colors.white.withValues(alpha: 0.4),
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ),
    );
  }
}
