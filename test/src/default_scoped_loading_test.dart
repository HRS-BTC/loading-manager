import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loading_manager/loading_manager.dart';

void main() {
  testWidgets("usage of DefaultLoadingProvider and DefaultLoadingHandler",
      (tester) async {
    const widget = DefaultScopedLoading(
      child: SizedBox(),
    );

    await tester.pumpWidget(widget);

    final finder = find.byType(DefaultLoadingProvider);
    final finder2 = find.byType(DefaultLoadingHandler);
    expect(finder, findsOneWidget);
    expect(finder2, findsOneWidget);
  });
}
