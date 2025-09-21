import 'package:flutter/material.dart';

/// Widget that displays the reset button at the top-right of the screen.
class ResetButton extends StatelessWidget {
  /// Callback function called when reset button is tapped.
  final VoidCallback onReset;

  /// Creates a [ResetButton] with the given [onReset] callback.
  const ResetButton({required this.onReset, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: 20,
      child: GestureDetector(
        onTap: onReset,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.red.withAlpha((0.8 * 255).round()),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.2 * 255).round()),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh, color: Colors.white, size: 18),
              SizedBox(width: 6),
              Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
