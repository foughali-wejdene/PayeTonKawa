import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr/main.dart';
import 'package:mspr/widget/background.dart';

void main() {
  testWidgets('MyApp should build without any error', (WidgetTester tester) async {
    // Build MyApp widget
    await tester.pumpWidget(const MyApp());

    // Verify that MyApp widget was successfully built
    expect(find.byType(MyApp), findsOneWidget);
  });

  test('UIData.next should return a random color', () {
    // Call UIData.next function to get a random color
    final color1 = UIData.next();
    final color2 = UIData.next();

    // Verify that two random colors are not equal
    expect(color1, isNot(equals(color2)));
  });
}
