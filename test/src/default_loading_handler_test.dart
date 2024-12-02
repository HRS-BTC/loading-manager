import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loading_manager/loading_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'default_loading_handler_test.mocks.dart';

abstract class TriggerHelper {
  void trigger(LoadingState state);
}

@GenerateNiceMocks([MockSpec<TriggerHelper>()])
void main() {
  testWidgets("render of RxVm using inherited", (tester) async {
    const widget = DefaultLoadingProvider(
      child: DefaultLoadingHandler(
        child: SizedBox(),
      ),
    );

    await tester.pumpWidget(widget);

    final finder = find.byType(RxConsumer<LoadingState>);
    expect(finder, findsOneWidget);
  });

  testWidgets("render of RxVm using passed instance", (tester) async {
    final loadingManager = DefaultLoadingManager();
    loadingManager.init();
    final widget = DefaultLoadingHandler(
      loadingManager: loadingManager,
      child: const SizedBox(),
    );

    await tester.pumpWidget(widget);

    final finder = find.byType(RxConsumer<LoadingState>);
    expect(finder, findsOneWidget);
  });

  group("buildLoading", () {
    testWidgets("initial state buildLoading", (tester) async {
      final loadingManager = DefaultLoadingManager();
      loadingManager.init();
      final widget = DefaultLoadingHandler(
        loadingManager: loadingManager,
        child: const SizedBox(),
      );

      await tester.pumpWidget(widget);

      final finder = find.byType(CupertinoActivityIndicator).hitTestable();
      final finder2 = find.byType(CircularProgressIndicator).hitTestable();
      expect(finder, findsNothing);
      expect(finder2, findsNothing);
    });

    testWidgets("loading state buildLoading Android", (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final loadingManager = DefaultLoadingManager();
      loadingManager.init();
      final widget = DefaultLoadingHandler(
        loadingManager: loadingManager,
        child: const SizedBox(),
      );

      await tester.pumpWidget(widget);
      loadingManager.push();
      await tester.pump();
      await tester.pump();

      final finder = find.byType(CircularProgressIndicator).hitTestable();
      expect(finder, findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets("loading state buildLoading iOS", (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final loadingManager = DefaultLoadingManager();
      loadingManager.init();
      final widget = DefaultLoadingHandler(
        loadingManager: loadingManager,
        child: const SizedBox(),
      );

      await tester.pumpWidget(widget);
      loadingManager.push();
      await tester.pump();
      await tester.pump();

      final finder = find.byType(CupertinoActivityIndicator).hitTestable();
      expect(finder, findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets("custom build loading function", (tester) async {
      const String loadingText = "loading...";
      Widget loadingBuilder(
          BuildContext context, LoadingState state, Widget child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              child,
              state.shouldShowLoading
                  ? const Text(loadingText)
                  : const SizedBox.shrink(),
            ],
          ),
        );
      }

      final loadingManager = DefaultLoadingManager();
      loadingManager.init();
      final widget = DefaultLoadingHandler(
        loadingManager: loadingManager,
        performBuildLoading: loadingBuilder,
        child: const SizedBox(),
      );

      await tester.pumpWidget(widget);
      loadingManager.push();
      await tester.pump();
      await tester.pump();

      final finder = find.text(loadingText);
      expect(finder, findsOneWidget);
    });
    testWidgets("stop loading", (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final loadingManager = DefaultLoadingManager();
      loadingManager.init();
      final widget = DefaultLoadingHandler(
        loadingManager: loadingManager,
        child: const SizedBox(),
      );

      await tester.pumpWidget(widget);
      loadingManager.push();
      loadingManager.pop();
      await tester.pump();
      await tester.pump();

      final finder = find.byType(CupertinoActivityIndicator).hitTestable();
      expect(finder, findsNothing);
      debugDefaultTargetPlatformOverride = null;
    });
  });

  group("call performHandleLoading", () {
    testWidgets("calling of performHandleLoading", (tester) async {
      final MockTriggerHelper helper = MockTriggerHelper();

      final loadingManager = DefaultLoadingManager();
      loadingManager.init();
      final widget = DefaultLoadingHandler(
        loadingManager: loadingManager,
        performHandleLoading: (context, state) {
          helper.trigger(state);
        },
        child: const SizedBox(),
      );

      await tester.pumpWidget(widget);
      loadingManager.push();
      await tester.pump();
      loadingManager.push();
      await tester.pump();
      loadingManager.pop();
      await tester.pump();

      verifyInOrder([
        helper.trigger(const LoadingState(loadStack: 0)),
        helper.trigger(const LoadingState(loadStack: 1)),
        helper.trigger(const LoadingState(loadStack: 2)),
        helper.trigger(const LoadingState(loadStack: 1)),
      ]);
      verifyNoMoreInteractions(helper);
    });
  });
}
