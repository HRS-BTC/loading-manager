import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loading_manager/loading_manager.dart';

void main() {
  testWidgets("usage of LoadingProvider", (tester) async {
    const widget = DefaultLoadingProvider(
      child: SizedBox(),
    );

    await tester.pumpWidget(widget);

    final finder = find.byType(LoadingProvider<DefaultLoadingManager>);
    expect(finder, findsOneWidget);
  });
}
