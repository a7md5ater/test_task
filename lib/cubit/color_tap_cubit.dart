import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/cubit/color_tap_state.dart';

/// Cubit that manages the state of the Color Tap application.
///
/// Handles tap events, color generation, and reset functionality.
class ColorTapCubit extends Cubit<ColorTapState> {
  /// Maximum RGB color value for generating 16,777,216 colors.
  static const int _maxColorValue = 0xFFFFFF;

  /// Opaque color value for setting the alpha channel to full opacity.
  static const int _opaqueColorValue = 0xFF000000;

  /// Duration for tap and color transition animations.
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Text displayed in the center of the screen.
  static const String displayText = 'Hello there';

  /// Random number generator for color generation.
  final math.Random _randomGenerator = math.Random();

  /// Creates a [ColorTapCubit] with the initial state.
  ColorTapCubit() : super(ColorTapState.initial());

  /// Handles screen tap by generating
  /// a new random color, incrementing counter, and playing animation.
  Future<void> handleTap() async {
    // Start animation
    emit(state.copyWith(isAnimating: true));

    // Wait for animation delay to make it visible
    await Future.delayed(const Duration(milliseconds: 50));

    // Update color and counter, stop animation
    final Color newColor = _generateRandomColor();
    emit(
      state.copyWith(
        backgroundColor: newColor,
        tapCounter: state.tapCounter + 1,
        isAnimating: false,
      ),
    );
  }

  /// Resets the application to its initial state.
  void reset() {
    emit(ColorTapState.initial());
  }

  /// Generates a random RGB color.
  ///
  /// Returns a [Color] with random RGB values
  /// ensuring 16,777,216 possible combinations.
  Color _generateRandomColor() {
    final int randomValue = _randomGenerator.nextInt(_maxColorValue + 1);

    return Color(_opaqueColorValue | randomValue);
  }
}
