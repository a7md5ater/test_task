import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/app/color_tap_app.dart';

void main() {
  group('Color Tap App Tests', () {
    testWidgets('Initial state verification', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const ColorTapApp());

      // Verify initial state
      expect(find.text('Hello there'), findsOneWidget);
      expect(find.text('Taps: 0'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
      expect(find.text('Current Color'), findsOneWidget);
      expect(
        find.text('#FFFFFF'),
        findsOneWidget,
      ); // White background initially
    });

    testWidgets('Tap functionality increments counter', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Verify initial counter
      expect(find.text('Taps: 0'), findsOneWidget);

      // Tap the screen once
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Verify counter incremented
      expect(find.text('Taps: 1'), findsOneWidget);
      expect(find.text('Taps: 0'), findsNothing);
    });

    testWidgets('Multiple taps increment counter correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Tap multiple times
      const int numberOfTaps = 5;
      for (int i = 0; i < numberOfTaps; i++) {
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();
      }

      // Verify final counter value
      expect(find.text('Taps: $numberOfTaps'), findsOneWidget);
    });

    testWidgets('Background color changes on tap', (WidgetTester tester) async {
      await tester.pumpWidget(const ColorTapApp());

      // Get initial background color
      final AnimatedContainer initialContainer = tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final BoxDecoration? initialDecoration =
          initialContainer.decoration as BoxDecoration?;
      final Color initialColor = initialDecoration?.color ?? Colors.transparent;

      // Tap the screen
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Get new background color
      final AnimatedContainer newContainer = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final BoxDecoration? newDecoration =
          newContainer.decoration as BoxDecoration?;
      final Color newColor = newDecoration?.color ?? Colors.transparent;

      // Verify color changed (though we can't predict the exact color)
      expect(newColor != initialColor, true);
    });

    testWidgets('Color hex display updates on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Verify initial hex color
      expect(find.text('#FFFFFF'), findsOneWidget);

      // Tap the screen
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Verify hex color changed (should no longer be white)
      expect(find.text('#FFFFFF'), findsNothing);

      // Find any hex color pattern (starts with #)
      final Finder hexColorFinder = find.byWidgetPredicate((widget) {
        if (widget is Text && widget.data != null) {
          return widget.data!.startsWith('#') && widget.data!.length == 7;
        }
        return false;
      });
      expect(hexColorFinder, findsOneWidget);
    });

    testWidgets('Reset button functionality', (WidgetTester tester) async {
      await tester.pumpWidget(const ColorTapApp());

      // Tap screen multiple times to change state
      const int numberOfTaps = 3;
      for (int i = 0; i < numberOfTaps; i++) {
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();
      }

      // Verify state changed
      expect(find.text('Taps: $numberOfTaps'), findsOneWidget);
      expect(find.text('#FFFFFF'), findsNothing);

      // Tap reset button
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      // Verify state reset
      expect(find.text('Taps: 0'), findsOneWidget);
      expect(find.text('#FFFFFF'), findsOneWidget);
    });

    testWidgets('Reset button resets background color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Tap screen to change color
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Tap reset button
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      // Verify background is back to white
      final AnimatedContainer container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final BoxDecoration? decoration = container.decoration as BoxDecoration?;
      expect(decoration?.color, equals(Colors.white));
    });

    testWidgets('UI elements are positioned correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Check that all main UI elements are present
      expect(find.byType(Stack), findsOneWidget);
      expect(
        find.byType(Positioned),
        findsNWidgets(4),
      ); // Counter, Reset, ColorInfo, MainText
      expect(
        find.byType(GestureDetector),
        findsNWidgets(2),
      ); // Screen tap + Reset button
    });

    testWidgets('Text contrast changes with background', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Get initial text widget
      final Text initialText = tester.widget<Text>(find.text('Hello there'));
      final Color initialTextColor = initialText.style!.color!;

      // For white background, text should be black
      expect(initialTextColor, equals(Colors.black));

      // Tap multiple times to potentially get a dark background
      // Note: This test might be flaky due to random colors, but demonstrates the concept
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        final Text currentText = tester.widget<Text>(find.text('Hello there'));
        final Color currentTextColor = currentText.style!.color!;

        // Text color should be either black or white (good contrast)
        expect(
          currentTextColor == Colors.black || currentTextColor == Colors.white,
          true,
          reason:
              'Text color should be either black or white for good contrast',
        );
      }
    });

    testWidgets('Animation scale effect works', (WidgetTester tester) async {
      await tester.pumpWidget(const ColorTapApp());

      // Find the AnimatedScale widget
      expect(find.byType(AnimatedScale), findsOneWidget);

      // The scale should initially be 1.0 (not animating)
      final AnimatedScale initialScale = tester.widget<AnimatedScale>(
        find.byType(AnimatedScale),
      );
      expect(initialScale.scale, equals(1.0));
    });

    testWidgets('App handles rapid taps correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Rapidly tap multiple times
      const int rapidTaps = 10;
      for (int i = 0; i < rapidTaps; i++) {
        await tester.tap(find.byType(GestureDetector));
        // Don't wait for settle to simulate rapid tapping
        await tester.pump();
      }

      // Wait for all animations to complete
      await tester.pumpAndSettle();

      // Counter should still be accurate
      expect(find.text('Taps: $rapidTaps'), findsOneWidget);
    });

    testWidgets('App maintains consistent UI structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Verify UI structure remains consistent after interactions
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Check all elements are still present
      expect(find.text('Hello there'), findsOneWidget);
      expect(find.textContaining('Taps:'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
      expect(find.text('Current Color'), findsOneWidget);
      expect(find.textContaining('#'), findsOneWidget);
    });
  });

  group('Edge Case Tests', () {
    testWidgets('App handles zero state correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Reset when already at zero
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      // Should still show correct initial state
      expect(find.text('Taps: 0'), findsOneWidget);
      expect(find.text('#FFFFFF'), findsOneWidget);
    });

    testWidgets('Color generation produces valid hex colors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ColorTapApp());

      // Test multiple color generations
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        // Find hex color text and validate format
        final Finder hexFinder = find.byWidgetPredicate((widget) {
          if (widget is Text && widget.data != null) {
            final String text = widget.data!;
            return text.startsWith('#') && text.length == 7;
          }
          return false;
        });

        expect(hexFinder, findsOneWidget);

        // Get the hex string and validate it's a valid hex color
        final Text hexWidget = tester.widget<Text>(hexFinder);
        final String hexColor = hexWidget.data!;
        final bool isValidHex = RegExp(r'^#[0-9A-F]{6}$').hasMatch(hexColor);
        expect(
          isValidHex,
          true,
          reason: 'Generated color $hexColor should be valid hex',
        );
      }
    });
  });
}
