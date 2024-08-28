// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lesson5/main.dart';
import 'package:lesson5/sign_in.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInPage(),
      ),
    );

    expect(find.text('門市'), findsOneWidget);
    expect(find.text('員工編號'), findsOneWidget);
    expect(find.text('登入'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).last, '190601100a');
    await tester.tap(find.text('登入'));
    await tester.pump();
    expect(find.text('員工編號格式輸入錯誤'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).last, '190601100');
    await tester.tap(find.text('登入'));
    await tester.pump();
    expect(find.text('員工編號格式輸入錯誤'), findsNothing);
  });
}
