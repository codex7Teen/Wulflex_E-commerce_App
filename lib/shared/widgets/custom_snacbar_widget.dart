import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';
import 'package:wulflex/core/utils/debouncer.dart'; // Import the Debouncer

class CustomSnackbar {
  // Create a static Debouncer instance
  static final Debouncer _debouncer = Debouncer(milliSeconds: 500);

  // Keep track of the current overlay to manage multiple snackbars
  static OverlayEntry? _currentOverlay;

  static void showCustomSnackBar(
    BuildContext context,
    String message, {
    IconData icon = Icons.done_outline_rounded,
    bool appearFromTop = false,
    Duration duration = const Duration(seconds: 2),
  }) {
    // Use the debouncer to prevent rapid successive calls
    _debouncer.run(() {
      // Remove any existing overlay first
      _currentOverlay?.remove();

      final overlay = Overlay.of(context);
      final overlayEntry = OverlayEntry(
        builder: (context) => _SnackbarContent(
          message: message,
          icon: icon,
          context: context,
          appearFromTop: appearFromTop,
        ),
      );

      // Insert the new overlay entry
      overlay.insert(overlayEntry);
      _currentOverlay = overlayEntry;

      // Remove the snackbar after the specified duration
      Future.delayed(duration, () {
        if (_currentOverlay == overlayEntry) {
          _currentOverlay?.remove();
          _currentOverlay = null;
        }
      });
    });
  }
}

class _SnackbarContent extends StatefulWidget {
  final String message;
  final IconData icon;
  final BuildContext context;
  final bool appearFromTop;

  const _SnackbarContent({
    required this.message,
    required this.icon,
    required this.context,
    required this.appearFromTop,
  });

  @override
  State<_SnackbarContent> createState() => _SnackbarContentState();
}

class _SnackbarContentState extends State<_SnackbarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.appearFromTop ? 40 : null,
      bottom: widget.appearFromTop ? null : 20,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: isLightTheme(widget.context)
                  ? AppColors.blackThemeColor
                  : AppColors.whiteThemeColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: isLightTheme(widget.context)
                      ? AppColors.whiteThemeColor
                      : AppColors.blackThemeColor,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    widget.message,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.snackBarText(widget.context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
