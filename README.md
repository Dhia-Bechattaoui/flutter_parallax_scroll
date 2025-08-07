# Flutter Parallax Scroll

A Flutter package for creating beautiful parallax scrolling effects with customizable speed and direction.

## Features

- 🎯 **Customizable Speed**: Control the intensity of parallax effects (0.0 to 2.0)
- 🧭 **Multiple Directions**: Forward, reverse, horizontal, and vertical parallax effects
- 🎮 **Easy Integration**: Simple API with extension methods for quick implementation
- 📱 **Performance Optimized**: Efficient scroll detection and smooth animations
- 🎨 **Flexible Configuration**: Fine-tune every aspect of the parallax behavior

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_parallax_scroll: ^0.0.3
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Usage

```dart
import 'package:flutter_parallax_scroll/flutter_parallax_scroll.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParallaxScrollView(
        child: ListView(
          children: [
            // Your content with parallax effects
            Container(
              height: 200,
              color: Colors.blue,
            ).asParallaxItem(
              config: ParallaxConfig(
                speed: 0.5,
                direction: ParallaxDirection.forward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Using Extension Methods

```dart
ListView(
  children: [
    // Apply parallax to any widget
    Image.asset('assets/background.jpg').asParallaxItem(
      config: ParallaxConfig(
        speed: 0.3,
        direction: ParallaxDirection.reverse,
      ),
    ),
    
    // Wrap scrollable content
    SingleChildScrollView().withParallax(
      config: ParallaxConfig(
        speed: 1.0,
        direction: ParallaxDirection.forward,
      ),
    ),
  ],
)
```

## API Reference

### ParallaxConfig

Configuration class for parallax effects:

```dart
ParallaxConfig({
  double speed = 1.0,                    // Speed multiplier (0.0 to 2.0)
  ParallaxDirection direction = ParallaxDirection.forward,
  bool enabled = true,                   // Enable/disable effect
  Offset offset = Offset.zero,           // Additional offset
})
```

### ParallaxDirection

Available parallax directions:

- `ParallaxDirection.forward` - Same direction as scroll
- `ParallaxDirection.reverse` - Opposite direction to scroll
- `ParallaxDirection.horizontal` - Horizontal movement on vertical scroll
- `ParallaxDirection.vertical` - Vertical movement on horizontal scroll

### ParallaxScrollView

Main widget for wrapping scrollable content:

```dart
ParallaxScrollView({
  required Widget child,
  ParallaxConfig config = const ParallaxConfig(),
  ParallaxScrollController? controller,
  bool enableScrollDirection = true,
  bool enableScrollState = true,
})
```

### ParallaxScrollItem

Widget for applying parallax effects to individual items:

```dart
ParallaxScrollItem({
  required Widget child,
  ParallaxConfig config = const ParallaxConfig(),
  ParallaxScrollController? controller,
  bool horizontal = true,
  bool vertical = true,
})
```

### ParallaxScrollController

Controller for managing parallax state:

```dart
final controller = ParallaxScrollController();

// Update configuration
controller.updateConfig(ParallaxConfig(speed: 1.5));

// Reset state
controller.reset();
```

## Examples

### Hero Section with Parallax Background

```dart
Container(
  height: 400,
  child: Stack(
    children: [
      // Parallax background
      Positioned.fill(
        child: Image.asset(
          'assets/hero-bg.jpg',
          fit: BoxFit.cover,
        ).asParallaxItem(
          config: ParallaxConfig(
            speed: 0.3,
            direction: ParallaxDirection.reverse,
          ),
        ),
      ),
      
      // Content
      Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
)
```

### Multiple Parallax Layers

```dart
ListView(
  children: [
    // Background layer (slowest)
    Container(
      height: 300,
      child: Image.asset('assets/bg.jpg').asParallaxItem(
        config: ParallaxConfig(speed: 0.2),
      ),
    ),
    
    // Middle layer (medium speed)
    Container(
      height: 200,
      child: Image.asset('assets/middle.png').asParallaxItem(
        config: ParallaxConfig(speed: 0.5),
      ),
    ),
    
    // Foreground layer (fastest)
    Container(
      height: 150,
      child: Image.asset('assets/foreground.png').asParallaxItem(
        config: ParallaxConfig(speed: 0.8),
      ),
    ),
  ],
)
```

### Horizontal Parallax

```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      Container(
        width: 200,
        height: 300,
        color: Colors.red,
      ).asParallaxItem(
        config: ParallaxConfig(
          speed: 0.5,
          direction: ParallaxDirection.horizontal,
        ),
      ),
      // More items...
    ],
  ),
).withParallax()
```

## Performance Tips

1. **Use appropriate speeds**: Lower speeds (0.1-0.5) work well for backgrounds, higher speeds (0.8-1.2) for foreground elements
2. **Limit parallax items**: Don't apply parallax to too many widgets simultaneously
3. **Disable when not needed**: Use `enabled: false` to disable effects when not visible
4. **Optimize images**: Use appropriately sized images for parallax backgrounds

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 