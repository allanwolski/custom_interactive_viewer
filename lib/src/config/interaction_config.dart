import 'package:flutter/material.dart';
import 'package:custom_interactive_viewer/src/enums/scroll_mode.dart';

/// Configuration for gesture and interaction behavior in CustomInteractiveViewer.
@immutable
class InteractionConfig {
  /// Whether to enable rotation of the content.
  final bool enableRotation;

  /// Whether to constrain the content to the widget bounds.
  final bool constrainBounds;

  /// Whether to enable fling behavior for smooth scrolling after a quick pan gesture.
  final bool enableFling;

  /// The scroll mode that determines allowed scroll directions.
  final ScrollMode scrollMode;

  /// The physics to use for the fling animation.
  /// Defaults to [BouncingScrollPhysics] for an iOS-like effect.
  final ScrollPhysics physics;

  /// Creates an interaction configuration.
  const InteractionConfig({
    this.enableRotation = false,
    this.constrainBounds = false,
    this.enableFling = true,
    this.scrollMode = ScrollMode.both,
    this.physics = const BouncingScrollPhysics(),
  });

  /// Creates a configuration with all interactions disabled.
  const InteractionConfig.disabled()
    : enableRotation = false,
      constrainBounds = true,
      enableFling = false,
      scrollMode = ScrollMode.none,
      physics = const NeverScrollableScrollPhysics();

  /// Creates a configuration optimized for image viewing.
  const InteractionConfig.imageViewer()
    : enableRotation = false,
      constrainBounds = true,
      enableFling = true,
      scrollMode = ScrollMode.both,
      physics = const BouncingScrollPhysics();

  /// Creates a copy of this configuration with the given fields replaced.
  InteractionConfig copyWith({
    bool? enableRotation,
    bool? constrainBounds,
    bool? enableFling,
    ScrollMode? scrollMode,
    ScrollPhysics? physics,
  }) {
    return InteractionConfig(
      enableRotation: enableRotation ?? this.enableRotation,
      constrainBounds: constrainBounds ?? this.constrainBounds,
      enableFling: enableFling ?? this.enableFling,
      scrollMode: scrollMode ?? this.scrollMode,
      physics: physics ?? this.physics,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionConfig &&
          runtimeType == other.runtimeType &&
          enableRotation == other.enableRotation &&
          constrainBounds == other.constrainBounds &&
          enableFling == other.enableFling &&
          scrollMode == other.scrollMode &&
          physics == other.physics;

  @override
  int get hashCode =>
      enableRotation.hashCode ^
      constrainBounds.hashCode ^
      enableFling.hashCode ^
      scrollMode.hashCode ^
      physics.hashCode;
}
