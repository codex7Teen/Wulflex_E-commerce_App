import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/home/presentation/widgets/image_viewer_screen_widgets.dart';

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
          //! Full Screen Image Gallery with Zoom
          ImageViewerScreenWidgets.buildFullsizeImage(
              context, widget.imageUrls, _pageController, (index) {
            setState(() {
              _currentIndex = index;
            });
          }),

          //! Close Button
          ImageViewerScreenWidgets.buildCloseButton(context),

          //! Page Indicator
          ImageViewerScreenWidgets.buildDottedPageIndicator(
              _pageController, widget.imageUrls),
        ],
      ),
    );
  }
}
