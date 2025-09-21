import 'package:flutter/material.dart';

/// Widget that displays the current color information
/// at the bottom of the screen.
class CurrentColor extends StatelessWidget {
  /// The hex color string to display.
  final String hexColor;

  /// Creates a [CurrentColor] with the given [hexColor].
  const CurrentColor({required this.hexColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.7 * 255).round()),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Color',
              style: TextStyle(
                color: Colors.white.withAlpha((0.8 * 255).round()),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hexColor,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
