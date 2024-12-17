import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wulflex/core/config/app_colors.dart';

class ScreenFullScreenImageViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ScreenFullScreenImageViewer({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  ScreenFullScreenImageViewerState createState() =>
      ScreenFullScreenImageViewerState();
}

class ScreenFullScreenImageViewerState
    extends State<ScreenFullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor(context),
      body: Stack(
        children: [
          // Full Screen Image Gallery with Zoom
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                  widget.imageUrls[index],
                ),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.imageUrls[index]),
              );
            },
            itemCount: widget.imageUrls.length,
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            loadingBuilder: (context, event) => Center(
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ?? 1),
              ),
            ),
          ),

          // Close Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Page Indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.imageUrls.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.greenThemeColor,
                  dotColor: Colors.white.withOpacity(0.4),
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
