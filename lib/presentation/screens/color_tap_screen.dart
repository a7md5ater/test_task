import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/cubit/color_tap_cubit.dart';
import 'package:test_task/cubit/color_tap_state.dart';
import 'package:test_task/presentation/widgets/current_color.dart';
import 'package:test_task/presentation/widgets/hello_there_text.dart';
import 'package:test_task/presentation/widgets/reset_button.dart';
import 'package:test_task/presentation/widgets/tap_counter.dart';

/// Main screen widget that displays the Color Tap interface.
///
/// Shows "Hello there" text in the center and responds to tap gestures.
class ColorTapScreen extends StatelessWidget {
  /// Creates a [ColorTapScreen] widget.
  const ColorTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ColorTapCubit, ColorTapState>(
        builder: (context, state) {
          final cubit = context.read<ColorTapCubit>();

          return GestureDetector(
            onTap: cubit.handleTap,
            child: AnimatedContainer(
              duration: ColorTapCubit.animationDuration,
              curve: Curves.easeInOut,
              width: double.infinity,
              height: double.infinity,
              color: state.backgroundColor,
              child: Stack(
                children: [
                  HelloThereText(
                    textColor: state.textColor,
                    animationScale: state.animationScale,
                  ),
                  TapCounter(tapCount: state.tapCounter),
                  ResetButton(onReset: cubit.reset),
                  CurrentColor(hexColor: state.hexColor),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
