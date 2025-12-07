// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:dreamsteps/main.dart';
import 'package:dreamsteps/state/dream_state.dart';

void main() {
  testWidgets('DreamSteps app loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => DreamState(),
        child: const DreamStepsApp(),
      ),
    );

    // Wait for initialization
    await tester.pumpAndSettle();

    // Verify that the app loads (should show SplashScreen initially)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
