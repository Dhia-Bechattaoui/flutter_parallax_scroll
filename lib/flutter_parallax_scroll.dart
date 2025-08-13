/// A Flutter package for creating beautiful parallax scrolling effects with customizable speed and direction.
///
/// This package provides:
/// - Customizable parallax speed (0.0 to 2.0)
/// - Multiple parallax directions (forward, reverse, horizontal, vertical)
/// - Easy integration with extension methods
/// - Performance-optimized scroll detection
/// - Flexible configuration options
///
/// ## Features
/// - **ParallaxScrollView**: Main widget for wrapping scrollable content
/// - **ParallaxScrollItem**: Widget for applying parallax effects to individual items
/// - **ParallaxScrollController**: Controller for managing parallax state
/// - **Extension methods**: Quick implementation with `.asParallaxItem()` and `.withParallax()`
///
/// ## Example
/// ```dart
/// import 'package:flutter_parallax_scroll/flutter_parallax_scroll.dart';
///
/// Container(
///   height: 200,
///   child: Image.asset('background.jpg').asParallaxItem(
///     config: ParallaxConfig(
///       speed: 0.5,
///       direction: ParallaxDirection.reverse,
///     ),
///   ),
/// )
/// ```
library flutter_parallax_scroll;

export 'src/parallax_scroll_view.dart';
export 'src/parallax_scroll_item.dart';
export 'src/parallax_scroll_controller.dart';
export 'src/parallax_direction.dart';
export 'src/parallax_config.dart';
