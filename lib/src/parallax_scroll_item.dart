import 'package:flutter/material.dart';
import 'parallax_config.dart';
import 'parallax_scroll_controller.dart';

/// A widget that applies parallax scrolling effects to its child
class ParallaxScrollItem extends StatefulWidget {
  /// The child widget to apply parallax effects to
  final Widget child;

  /// Configuration for the parallax effect
  final ParallaxConfig config;

  /// Optional controller to manage the parallax effect
  final ParallaxScrollController? controller;

  /// Whether to apply the effect horizontally
  final bool horizontal;

  /// Whether to apply the effect vertically
  final bool vertical;

  /// Creates a parallax scroll item
  const ParallaxScrollItem({
    super.key,
    required this.child,
    this.config = const ParallaxConfig(),
    this.controller,
    this.horizontal = true,
    this.vertical = true,
  });

  @override
  State<ParallaxScrollItem> createState() => _ParallaxScrollItemState();
}

class _ParallaxScrollItemState extends State<ParallaxScrollItem> {
  late ParallaxScrollController _controller;
  double _parallaxOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ParallaxScrollController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(ParallaxScrollItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onControllerChanged);
      _controller = widget.controller ?? ParallaxScrollController();
      _controller.addListener(_onControllerChanged);
    }
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {
        _parallaxOffset = _controller.calculateParallaxOffset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.config.enabled) {
      return widget.child;
    }

    return Transform.translate(
      offset: Offset(
        widget.horizontal ? _parallaxOffset : 0.0,
        widget.vertical ? _parallaxOffset : 0.0,
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
