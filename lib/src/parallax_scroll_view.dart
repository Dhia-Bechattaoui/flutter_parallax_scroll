import 'package:flutter/material.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ParallaxScrollController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScrollChanged);
  }

  @override
  void didUpdateWidget(ParallaxScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? ParallaxScrollController();
    }
  }

  void _onScrollChanged() {
    final offset = _scrollController.offset;
    _controller.updateScrollOffset(offset);

    if (widget.enableScrollDirection) {
      final direction = _scrollController.position.userScrollDirection;
      _controller.updateScrollDirection(direction);
    }

    if (widget.enableScrollState) {
      final isScrolling = _scrollController.position.isScrollingNotifier.value;
      _controller.updateScrollingState(isScrolling);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          _controller.updateScrollOffset(notification.metrics.pixels);
        }
        return false;
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChanged);
    _scrollController.dispose();
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
