import 'package:flutter/material.dart';
import 'package:test_task/cubit/color_tap_cubit.dart';

/// Widget that displays the main "Hello there" text
/// in the center of the screen.
class HelloThereText extends StatelessWidget {
  /// The text color to use.
  final Color textColor;

  /// The animation scale to apply.
  final double animationScale;

  /// Creates a [HelloThereText] with the
  /// given [textColor] and [animationScale].
  const HelloThereText({
    required this.textColor,
    required this.animationScale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedScale(
        scale: animationScale,
        duration: ColorTapCubit.animationDuration,
        curve: Curves.easeInOut,
        child: Text(
          ColorTapCubit.displayText,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textColor,
            shadows: [
              Shadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: textColor.withAlpha((0.3 * 255).round()),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
