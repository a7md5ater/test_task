import 'package:flutter/material.dart';

/// Widget that displays the tap counter at the top-left of the screen.
class TapCounter extends StatelessWidget {
  /// The current tap count to display.
  final int tapCount;

  /// Creates a [TapCounter] with the given [tapCount].
  const TapCounter({required this.tapCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.7 * 255).round()),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Taps: $tapCount',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
