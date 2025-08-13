import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'parallax_config.dart';
import 'parallax_scroll_controller.dart';
import 'parallax_scroll_item.dart';

/// A scrollable widget that provides parallax effects to its children
class ParallaxScrollView extends StatefulWidget {
  /// The scrollable widget to wrap (e.g., ListView, SingleChildScrollView)
  final Widget child;

  /// Configuration for the parallax effect
  final ParallaxConfig config;

  /// Optional controller to manage the parallax effect
  final ParallaxScrollController? controller;

  /// Whether to enable scroll direction detection
  final bool enableScrollDirection;

  /// Whether to enable scroll state detection
  final bool enableScrollState;

  /// Creates a parallax scroll view
  const ParallaxScrollView({
    super.key,
    required this.child,
    this.config = const ParallaxConfig(),
    this.controller,
    this.enableScrollDirection = true,
    this.enableScrollState = true,
  });

  @override
  State<ParallaxScrollView> createState() => _ParallaxScrollViewState();
}

class _ParallaxScrollViewState extends State<ParallaxScrollView> {
  late ParallaxScrollController _controller;
  double _lastScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ParallaxScrollController();
  }

  @override
  void didUpdateWidget(ParallaxScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? ParallaxScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final offset = notification.metrics.pixels;
          _controller.updateScrollOffset(offset);

          if (widget.enableScrollDirection) {
            final currentOffset = notification.metrics.pixels;
            final direction = currentOffset > _lastScrollOffset
                ? ScrollDirection.forward
                : currentOffset < _lastScrollOffset
                    ? ScrollDirection.reverse
                    : ScrollDirection.idle;
            _controller.updateScrollDirection(direction);
            _lastScrollOffset = currentOffset;
          }

          if (widget.enableScrollState) {
            _controller.updateScrollingState(true);
          }
        }
        return false;
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// Extension to provide easy access to parallax effects in existing widgets
extension ParallaxScrollViewExtension on Widget {
  /// Wraps this widget with parallax scroll effects
  Widget withParallax({
    ParallaxConfig config = const ParallaxConfig(),
    ParallaxScrollController? controller,
    bool enableScrollDirection = true,
    bool enableScrollState = true,
  }) {
    return ParallaxScrollView(
      config: config,
      controller: controller,
      enableScrollDirection: enableScrollDirection,
      enableScrollState: enableScrollState,
      child: this,
    );
  }

  /// Wraps this widget with parallax item effects
  Widget asParallaxItem({
    ParallaxConfig config = const ParallaxConfig(),
    ParallaxScrollController? controller,
    bool horizontal = true,
    bool vertical = true,
  }) {
    return ParallaxScrollItem(
      config: config,
      controller: controller,
      horizontal: horizontal,
      vertical: vertical,
      child: this,
    );
  }
}
