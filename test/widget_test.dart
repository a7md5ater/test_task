import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/app/color_tap_app.dart';

/// Test constants
class TestConstants {
  static const int multipleTestTaps = 5;
  static const int rapidTapCount = 10;
  static const int colorTestIterations = 5;
  static const String initialHexColor = '#FFFFFF';
  static const String helloThereText = 'Hello there';
  static const String tapsPrefix = 'Taps:';
  static const String resetButtonText = 'Reset';
  static const String currentColorText = 'Current Color';
  static const int expectedPositionedWidgets = 4;
  static const int expectedGestureDetectors = 2;
  static const int hexColorLength = 7;
  static const double initialAnimationScale = 1.0;
}

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

void main() {
  group('Color Tap App - Initial State Tests', () {
    testWidgets('App displays correct initial state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      TestHelpers.verifyInitialState();
    });
  });

  group('Color Tap App - Counter Tests', () {
    testWidgets('Single tap increments counter', (WidgetTester tester) async {
      await tester.pumpWidget(const ColorTapApp());

      expect(find.text('${TestConstants.tapsPrefix} 0'), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.text('${TestConstants.tapsPrefix} 1'), findsOneWidget);
      expect(find.text('${TestConstants.tapsPrefix} 0'), findsNothing);
    });

    testWidgets('Multiple taps increment counter correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      await TestHelpers.performMultipleTaps(
        tester,
        TestConstants.multipleTestTaps,
      );

      expect(
        find.text(
          '${TestConstants.tapsPrefix} ${TestConstants.multipleTestTaps}',
        ),
        findsOneWidget,
      );
    });

    testWidgets('Rapid taps are handled correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      await TestHelpers.performRapidTaps(tester, TestConstants.rapidTapCount);
      await tester.pumpAndSettle();

      expect(
        find.text('${TestConstants.tapsPrefix} ${TestConstants.rapidTapCount}'),
        findsOneWidget,
      );
    });
  });

  group('Color Tap App - Color Tests', () {
    testWidgets('Background color changes on tap', (WidgetTester tester) async {
      await tester.pumpWidget(const ColorTapApp());

      final Color initialColor = TestHelpers.getBackgroundColor(tester);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      final Color newColor = TestHelpers.getBackgroundColor(tester);

      expect(newColor != initialColor, true);
    });

    testWidgets('Hex color display updates correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      expect(find.text(TestConstants.initialHexColor), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.text(TestConstants.initialHexColor), findsNothing);

      final Finder hexColorFinder = find.byWidgetPredicate((widget) {
        if (widget is Text && widget.data != null) {
          final String? text = widget.data;
          if (text == null) return false;

          return text.startsWith('#') &&
              text.length == TestConstants.hexColorLength;
        }

        return false;
      });
      expect(hexColorFinder, findsOneWidget);
    });

    testWidgets('Generated colors are valid hex format', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      for (int i = 0; i < TestConstants.colorTestIterations; i++) {
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        final String hexColor = TestHelpers.getHexColorText(tester);
        final bool isValid = TestHelpers.isValidHexColor(hexColor);

        expect(
          isValid,
          true,
          reason: 'Generated color $hexColor should be valid hex',
        );
      }
    });
  });

  group('Color Tap App - Reset Tests', () {
    testWidgets('Reset button resets counter', (WidgetTester tester) async {
      await tester.pumpWidget(const ColorTapApp());

      await TestHelpers.performMultipleTaps(
        tester,
        TestConstants.multipleTestTaps,
      );

      expect(
        find.text(
          '${TestConstants.tapsPrefix} ${TestConstants.multipleTestTaps}',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text(TestConstants.resetButtonText));
      await tester.pumpAndSettle();

      expect(find.text('${TestConstants.tapsPrefix} 0'), findsOneWidget);
    });

    testWidgets('Reset button restores initial color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.text(TestConstants.initialHexColor), findsNothing);

      await tester.tap(find.text(TestConstants.resetButtonText));
      await tester.pumpAndSettle();

      expect(find.text(TestConstants.initialHexColor), findsOneWidget);

      final Color backgroundColor = TestHelpers.getBackgroundColor(tester);
      expect(backgroundColor, equals(Colors.white));
    });

    testWidgets('Reset works when already at initial state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      await tester.tap(find.text(TestConstants.resetButtonText));
      await tester.pumpAndSettle();

      expect(find.text('${TestConstants.tapsPrefix} 0'), findsOneWidget);
      expect(find.text(TestConstants.initialHexColor), findsOneWidget);
    });
  });

  group('Color Tap App - UI Structure Tests', () {
    testWidgets('All UI elements are positioned correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      expect(find.byType(Stack), findsOneWidget);
      expect(
        find.byType(Positioned),
        findsNWidgets(TestConstants.expectedPositionedWidgets),
      );
      expect(
        find.byType(GestureDetector),
        findsNWidgets(TestConstants.expectedGestureDetectors),
      );
    });

    testWidgets('UI maintains structure after interactions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.text(TestConstants.helloThereText), findsOneWidget);
      expect(find.textContaining(TestConstants.tapsPrefix), findsOneWidget);
      expect(find.text(TestConstants.resetButtonText), findsOneWidget);
      expect(find.text(TestConstants.currentColorText), findsOneWidget);
      expect(find.textContaining('#'), findsOneWidget);
    });
  });

  group('Color Tap App - Accessibility Tests', () {
    testWidgets('Text color provides good contrast', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      final Color initialTextColor = TestHelpers.getMainTextColor(tester);
      expect(initialTextColor, equals(Colors.black));

      for (int i = 0; i < TestConstants.colorTestIterations; i++) {
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        final Color currentTextColor = TestHelpers.getMainTextColor(tester);

        expect(
          currentTextColor == Colors.black || currentTextColor == Colors.white,
          true,
          reason:
              'Text color should be either black or white for good contrast',
        );
      }
    });
  });

  group('Color Tap App - Animation Tests', () {
    testWidgets('Animation scale widget is present', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      expect(find.byType(AnimatedScale), findsOneWidget);

      final AnimatedScale scaleWidget = tester.widget<AnimatedScale>(
        find.byType(AnimatedScale),
      );
      expect(scaleWidget.scale, equals(TestConstants.initialAnimationScale));
    });
  });
}
