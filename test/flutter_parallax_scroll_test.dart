import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_parallax_scroll/flutter_parallax_scroll.dart';

void main() {
  group('ParallaxScrollController Tests', () {
    test('should initialize with default values', () {
      final controller = ParallaxScrollController();

      expect(controller.scrollOffset, 0.0);
      expect(controller.scrollDirection, ScrollDirection.idle);
      expect(controller.isScrolling, false);
      expect(controller.config.speed, 1.0);
      expect(controller.config.direction, ParallaxDirection.forward);
      expect(controller.config.enabled, true);
    });

    test('should update scroll offset', () {
      final controller = ParallaxScrollController();
      controller.updateScrollOffset(100.0);

      expect(controller.scrollOffset, 100.0);
    });

    test('should update scroll direction', () {
      final controller = ParallaxScrollController();
      controller.updateScrollDirection(ScrollDirection.forward);

      expect(controller.scrollDirection, ScrollDirection.forward);
    });

    test('should update scrolling state', () {
      final controller = ParallaxScrollController();
      controller.updateScrollingState(true);

      expect(controller.isScrolling, true);
    });

    test('should update configuration', () {
      final controller = ParallaxScrollController();
      final newConfig = ParallaxConfig(
        speed: 1.5,
        direction: ParallaxDirection.reverse,
        enabled: false,
      );

      controller.updateConfig(newConfig);

      expect(controller.config.speed, 1.5);
      expect(controller.config.direction, ParallaxDirection.reverse);
      expect(controller.config.enabled, false);
    });

    test('should calculate parallax offset correctly for forward direction',
        () {
      final controller = ParallaxScrollController();
      controller.updateConfig(ParallaxConfig(
        speed: 0.5,
        direction: ParallaxDirection.forward,
      ));
      controller.updateScrollOffset(100.0);

      expect(controller.calculateParallaxOffset(), 50.0);
    });

    test('should calculate parallax offset correctly for reverse direction',
        () {
      final controller = ParallaxScrollController();
      controller.updateConfig(ParallaxConfig(
        speed: 0.5,
        direction: ParallaxDirection.reverse,
      ));
      controller.updateScrollOffset(100.0);

      expect(controller.calculateParallaxOffset(), -50.0);
    });

    test('should return 0 when disabled', () {
      final controller = ParallaxScrollController();
      controller.updateConfig(ParallaxConfig(enabled: false));
      controller.updateScrollOffset(100.0);

      expect(controller.calculateParallaxOffset(), 0.0);
    });

    test('should reset state', () {
      final controller = ParallaxScrollController();
      controller.updateScrollOffset(100.0);
      controller.updateScrollDirection(ScrollDirection.forward);
      controller.updateScrollingState(true);

      controller.reset();

      expect(controller.scrollOffset, 0.0);
      expect(controller.scrollDirection, ScrollDirection.idle);
      expect(controller.isScrolling, false);
    });
  });

  group('ParallaxConfig Tests', () {
    test('should create with default values', () {
      const config = ParallaxConfig();

      expect(config.speed, 1.0);
      expect(config.direction, ParallaxDirection.forward);
      expect(config.enabled, true);
      expect(config.offset, Offset.zero);
    });

    test('should create with custom values', () {
      const config = ParallaxConfig(
        speed: 1.5,
        direction: ParallaxDirection.reverse,
        enabled: false,
        offset: Offset(10, 20),
      );

      expect(config.speed, 1.5);
      expect(config.direction, ParallaxDirection.reverse);
      expect(config.enabled, false);
      expect(config.offset, const Offset(10, 20));
    });

    test('should copy with new values', () {
      const original = ParallaxConfig(
        speed: 1.0,
        direction: ParallaxDirection.forward,
        enabled: true,
        offset: Offset.zero,
      );

      final copied = original.copyWith(
        speed: 2.0,
        direction: ParallaxDirection.reverse,
      );

      expect(copied.speed, 2.0);
      expect(copied.direction, ParallaxDirection.reverse);
      expect(copied.enabled, true);
      expect(copied.offset, Offset.zero);
    });

    test('should be equal when values are the same', () {
      const config1 = ParallaxConfig(
        speed: 1.5,
        direction: ParallaxDirection.reverse,
        enabled: false,
        offset: Offset(10, 20),
      );

      const config2 = ParallaxConfig(
        speed: 1.5,
        direction: ParallaxDirection.reverse,
        enabled: false,
        offset: Offset(10, 20),
      );

      expect(config1, equals(config2));
    });

    test('should have different hash codes for different values', () {
      const config1 = ParallaxConfig(speed: 1.0);
      const config2 = ParallaxConfig(speed: 2.0);

      expect(config1.hashCode, isNot(equals(config2.hashCode)));
    });
  });

  group('ParallaxDirection Tests', () {
    test('should have correct enum values', () {
      expect(ParallaxDirection.values, hasLength(4));
      expect(ParallaxDirection.forward, isA<ParallaxDirection>());
      expect(ParallaxDirection.reverse, isA<ParallaxDirection>());
      expect(ParallaxDirection.horizontal, isA<ParallaxDirection>());
      expect(ParallaxDirection.vertical, isA<ParallaxDirection>());
    });
  });

  group('Widget Tests', () {
    testWidgets('ParallaxScrollItem should render child when disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ParallaxScrollItem(
              config: const ParallaxConfig(enabled: false),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      // When disabled, it should still render the child
      expect(find.byType(ParallaxScrollItem), findsOneWidget);
    });

    testWidgets('ParallaxScrollItem should apply transform when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ParallaxScrollItem(
              config: const ParallaxConfig(enabled: true),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(ParallaxScrollItem), findsOneWidget);
    });

    testWidgets('ParallaxScrollView should render child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ParallaxScrollView(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(ParallaxScrollView), findsOneWidget);
    });
  });
}
