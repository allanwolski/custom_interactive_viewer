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

  /// Creates an interaction configuration.
  const InteractionConfig({
    this.enableRotation = false,
    this.constrainBounds = false,
    this.enableFling = true,
    this.scrollMode = ScrollMode.both,
  });

  /// Creates a configuration with all interactions disabled.
  const InteractionConfig.disabled()
    : enableRotation = false,
      constrainBounds = true,
      enableFling = false,
      scrollMode = ScrollMode.none;

  /// Creates a configuration optimized for image viewing.
  const InteractionConfig.imageViewer()
    : enableRotation = false,
      constrainBounds = true,
      enableFling = true,
      scrollMode = ScrollMode.both;

  /// Creates a copy of this configuration with the given fields replaced.
  InteractionConfig copyWith({
    bool? enableRotation,
    bool? constrainBounds,
    bool? enableFling,
    ScrollMode? scrollMode,
  }) {
    return InteractionConfig(
      enableRotation: enableRotation ?? this.enableRotation,
      constrainBounds: constrainBounds ?? this.constrainBounds,
      enableFling: enableFling ?? this.enableFling,
      scrollMode: scrollMode ?? this.scrollMode,
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
          scrollMode == other.scrollMode;

  @override
  int get hashCode =>
      enableRotation.hashCode ^
      constrainBounds.hashCode ^
      enableFling.hashCode ^
      scrollMode.hashCode;
}
