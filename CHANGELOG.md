# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.3] - 2024-01-01

### Fixed
- Fixed Dart formatting issues in `parallax_scroll_controller.dart`
- Ensured all files follow proper Dart formatting standards
- Improved code consistency and readability

## [0.0.2] - 2024-01-01

### Fixed
- Fixed unnecessary override warning in `ParallaxScrollController.dispose()` method
- Improved code quality by removing redundant code
- All static analysis issues resolved

## [0.0.1] - 2024-01-01

### Added
- Initial release of Flutter Parallax Scroll package
- `ParallaxScrollView` widget for wrapping scrollable content
- `ParallaxScrollItem` widget for applying parallax effects to individual items
- `ParallaxScrollController` for managing parallax state and configuration
- `ParallaxConfig` class for fine-tuning parallax behavior
- `ParallaxDirection` enum with four direction options:
  - `forward` - Same direction as scroll
  - `reverse` - Opposite direction to scroll
  - `horizontal` - Horizontal movement on vertical scroll
  - `vertical` - Vertical movement on horizontal scroll
- Extension methods for easy integration:
  - `.withParallax()` - Wrap widgets with parallax scroll view
  - `.asParallaxItem()` - Apply parallax effects to widgets
- Comprehensive example app demonstrating all features
- Full test coverage for all components
- Detailed documentation and API reference

### Features
- Customizable speed multiplier (0.0 to 2.0)
- Enable/disable parallax effects
- Additional offset support
- Scroll direction and state detection
- Performance optimized with efficient scroll detection
- Support for both horizontal and vertical scrolling
- Multiple parallax layers with different speeds 