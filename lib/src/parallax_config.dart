import 'package:flutter/material.dart';
import 'parallax_direction.dart';

/// Configuration for parallax scrolling effects
class ParallaxConfig {
  /// The speed multiplier for the parallax effect (0.0 to 2.0)
  ///
  /// - 0.0: No movement (static)
  /// - 0.5: Half speed
  /// - 1.0: Normal speed
  /// - 1.5: 1.5x speed
  /// - 2.0: Double speed
  final double speed;

  /// The direction of the parallax effect
  final ParallaxDirection direction;

  /// Whether to enable the parallax effect
  final bool enabled;

  /// The offset to apply to the parallax effect
  final Offset offset;

  /// Creates a parallax configuration
  const ParallaxConfig({
    this.speed = 1.0,
    this.direction = ParallaxDirection.forward,
    this.enabled = true,
    this.offset = Offset.zero,
  });

  /// Creates a copy of this configuration with the given fields replaced
  ParallaxConfig copyWith({
    double? speed,
    ParallaxDirection? direction,
    bool? enabled,
    Offset? offset,
  }) {
    return ParallaxConfig(
      speed: speed ?? this.speed,
      direction: direction ?? this.direction,
      enabled: enabled ?? this.enabled,
      offset: offset ?? this.offset,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ParallaxConfig &&
        other.speed == speed &&
        other.direction == direction &&
        other.enabled == enabled &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    return Object.hash(speed, direction, enabled, offset);
  }

  @override
  String toString() {
    return 'ParallaxConfig(speed: $speed, direction: $direction, enabled: $enabled, offset: $offset)';
  }
}
