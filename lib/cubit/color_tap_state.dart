import 'package:flutter/material.dart';

/// Represents the state of the Color Tap application.
///
/// Contains the current background color, tap counter, and animation state.
class ColorTapState {
  /// The current background color of the screen.
  final Color backgroundColor;

  /// The number of times the screen has been tapped.
  final int tapCounter;

  /// Whether the tap animation is currently playing.
  final bool isAnimating;

  /// Creates a [ColorTapState] with the given parameters.
  const ColorTapState({
    required this.backgroundColor,
    required this.tapCounter,
    required this.isAnimating,
  });

  /// Initial state with default values.
  factory ColorTapState.initial() {
    return const ColorTapState(
      backgroundColor: Colors.white,
      tapCounter: 0,
      isAnimating: false,
    );
  }

  /// Creates a copy of this state with the given fields replaced.
  ColorTapState copyWith({
    Color? backgroundColor,
    int? tapCounter,
    bool? isAnimating,
  }) {
    return ColorTapState(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      tapCounter: tapCounter ?? this.tapCounter,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }

  /// Calculates the contrasting text color
  /// based on the background color luminance.
  Color get textColor {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Returns the hex representation of the current background color.
  String get hexColor {
    final red = ((backgroundColor.toARGB32() >> 16) & 0xFF)
        .toRadixString(16)
        .padLeft(2, '0');
    final green = ((backgroundColor.toARGB32() >> 8) & 0xFF)
        .toRadixString(16)
        .padLeft(2, '0');
    final blue = (backgroundColor.toARGB32() & 0xFF)
        .toRadixString(16)
        .padLeft(2, '0');
    return '#$red$green$blue'.toUpperCase();
  }

  /// Returns the scale value for tap animation.
  double get animationScale => isAnimating ? 0.95 : 1.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ColorTapState &&
        other.backgroundColor == backgroundColor &&
        other.tapCounter == tapCounter &&
        other.isAnimating == isAnimating;
  }

  @override
  int get hashCode =>
      backgroundColor.hashCode ^ tapCounter.hashCode ^ isAnimating.hashCode;
}
