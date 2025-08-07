import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'parallax_config.dart';
import 'parallax_direction.dart';

/// Controller for managing parallax scroll effects
class ParallaxScrollController extends ChangeNotifier {
  /// Current scroll offset
  double _scrollOffset = 0.0;

  /// Current scroll direction
  ScrollDirection _scrollDirection = ScrollDirection.idle;

  /// Whether the scroll view is currently scrolling
  bool _isScrolling = false;

  /// Configuration for the parallax effect
  ParallaxConfig _config = const ParallaxConfig();

  /// Get the current scroll offset
  double get scrollOffset => _scrollOffset;

  /// Get the current scroll direction
  ScrollDirection get scrollDirection => _scrollDirection;

  /// Get whether the scroll view is currently scrolling
  bool get isScrolling => _isScrolling;

  /// Get the current configuration
  ParallaxConfig get config => _config;

  /// Update the scroll offset and notify listeners
  void updateScrollOffset(double offset) {
    if (_scrollOffset != offset) {
      _scrollOffset = offset;
      notifyListeners();
    }
  }

  /// Update the scroll direction and notify listeners
  void updateScrollDirection(ScrollDirection direction) {
    if (_scrollDirection != direction) {
      _scrollDirection = direction;
      notifyListeners();
    }
  }

  /// Update the scrolling state and notify listeners
  void updateScrollingState(bool isScrolling) {
    if (_isScrolling != isScrolling) {
      _isScrolling = isScrolling;
      notifyListeners();
    }
  }

  /// Update the parallax configuration
  void updateConfig(ParallaxConfig config) {
    if (_config != config) {
      _config = config;
      notifyListeners();
    }
  }

  /// Calculate the parallax offset based on current scroll and configuration
  double calculateParallaxOffset() {
    if (!_config.enabled) return 0.0;

    double baseOffset = _scrollOffset * _config.speed;

    switch (_config.direction) {
      case ParallaxDirection.forward:
        return baseOffset;
      case ParallaxDirection.reverse:
        return -baseOffset;
      case ParallaxDirection.horizontal:
        return baseOffset;
      case ParallaxDirection.vertical:
        return baseOffset;
    }
  }

  /// Reset the controller state
  void reset() {
    _scrollOffset = 0.0;
    _scrollDirection = ScrollDirection.idle;
    _isScrolling = false;
    notifyListeners();
  }
}
