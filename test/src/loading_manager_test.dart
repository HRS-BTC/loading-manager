import 'package:flutter_test/flutter_test.dart';
import 'package:loading_manager/loading_manager.dart';

void main() {
  late LoadingManager loadingManager;
  const defaultLoadingState = LoadingState();

  setUp(() {
    loadingManager = DefaultLoadingManager();
  });

  test("not init", () async {
    void getCurrentState() => loadingManager.state;
    expect(getCurrentState, throwsA(const LoadingManagerNotInitialized()));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("init", () {
    loadingManager.init();
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    final loadingState = loadingManager.state;
    expect(loadingState, defaultLoadingState);
    expectLater(loadingStatesSubject, emits(defaultLoadingState));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("initLoadingManager", () {
    loadingManager.initLoadingManager();
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    final loadingState = loadingManager.state;
    expect(loadingState, defaultLoadingState);
    expectLater(loadingStatesSubject, emits(defaultLoadingState));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("clear", () {
    loadingManager.clear();
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    final loadingState = loadingManager.state;
    expect(loadingState, defaultLoadingState);
    expectLater(loadingStatesSubject, emits(defaultLoadingState));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("reset", () {
    loadingManager.reset();
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    final loadingState = loadingManager.state;
    expect(loadingState, defaultLoadingState);
    expectLater(loadingStatesSubject, emits(defaultLoadingState));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("push future", () async {
    final future = Future.delayed(const Duration(milliseconds: 300));
    loadingManager.init();
    loadingManager.pushFuture(future: future);
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    expectLater(
        loadingStatesSubject,
        emitsInOrder([
          const LoadingState(loadStack: 1),
          const LoadingState(loadStack: 0),
        ]));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("push amount", () async {
    const amount = 5;
    loadingManager.init();
    loadingManager.pushAmount(amount: amount);
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    expectLater(
        loadingStatesSubject,
        emitsInOrder([
          const LoadingState(loadStack: amount),
        ]));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("push", () async {
    const amount = 5;
    loadingManager.init();
    loadingManager.push(amount: amount);
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    expectLater(
        loadingStatesSubject,
        emitsInOrder([
          const LoadingState(loadStack: amount),
        ]));
    addTearDown(() {
      loadingManager.dispose();
    });
  });

  test("pop", () async {
    const amount = 5;
    loadingManager.init();
    loadingManager.pop(amount: amount);
    final loadingStatesSubject = loadingManager.stateChangedSubject;
    expectLater(
        loadingStatesSubject,
        emitsInOrder([
          defaultLoadingState,
        ]));
    addTearDown(() {
      loadingManager.dispose();
    });
  });
}
