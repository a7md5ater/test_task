import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_constants.dart';

/// Test helper functions
class TestHelpers {
  /// Performs multiple taps on the screen
  static Future<void> performMultipleTaps(
    WidgetTester tester,
    int numberOfTaps,
  ) async {
    for (int i = 0; i < numberOfTaps; i++) {
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();
    }
  }

  /// Performs rapid taps without waiting for settle
  static Future<void> performRapidTaps(
    WidgetTester tester,
    int numberOfTaps,
  ) async {
    for (int i = 0; i < numberOfTaps; i++) {
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
    }
  }

  /// Gets the background color from AnimatedContainer
  static Color getBackgroundColor(WidgetTester tester) {
    final AnimatedContainer container = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    final decoration = container.decoration;
    if (decoration is BoxDecoration && decoration.color != null) {
      return decoration.color ?? Colors.transparent;
    }

    return Colors.transparent;
  }

  /// Validates hex color format
  static bool isValidHexColor(String hexColor) {
    final RegExp hexPattern = RegExp(r'^#[0-9A-F]{6}$');

    return hexPattern.hasMatch(hexColor);
  }

  /// Finds hex color widget and returns its text
  static String getHexColorText(WidgetTester tester) {
    final Finder hexFinder = find.byWidgetPredicate((widget) {
      if (widget is Text && widget.data != null) {
        final String? text = widget.data;
        if (text == null) return false;

        return text.startsWith('#') &&
            text.length == TestConstants.hexColorLength;
      }

      return false;
    });

    final Text hexWidget = tester.widget<Text>(hexFinder);

    return hexWidget.data ?? '';
  }

  /// Gets text color from main text widget
  static Color getMainTextColor(WidgetTester tester) {
    final Text textWidget = tester.widget<Text>(
      find.text(TestConstants.helloThereText),
    );

    return textWidget.style?.color ?? Colors.transparent;
  }

  /// Verifies initial app state
  static void verifyInitialState() {
    expect(find.text(TestConstants.helloThereText), findsOneWidget);
    expect(find.text('${TestConstants.tapsPrefix} 0'), findsOneWidget);
    expect(find.text(TestConstants.resetButtonText), findsOneWidget);
    expect(find.text(TestConstants.currentColorText), findsOneWidget);
    expect(find.text(TestConstants.initialHexColor), findsOneWidget);
  }
}
