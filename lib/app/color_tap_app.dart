import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/cubit/color_tap_cubit.dart';
import 'package:test_task/presentation/screens/color_tap_screen.dart';

/// Root widget of the Color Tap application.
///
/// This widget sets up the MaterialApp with theme configuration
/// and provides the BlocProvider for state management.
class ColorTapApp extends StatelessWidget {
  /// Creates a [ColorTapApp] widget.
  const ColorTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Tap Challenge',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: BlocProvider(
        create: (context) => ColorTapCubit(),
        child: const ColorTapScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
