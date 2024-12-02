import 'package:flutter_test/flutter_test.dart';
import 'package:loading_manager/loading_manager.dart';

void main() {
  test("default loadStack = 0", () {
    LoadingState loadingState = const LoadingState();
    expect(loadingState.loadStack, 0);
  });

  test("should loading when loadStack > 0", () {
    LoadingState loadingState = const LoadingState(loadStack: 1);
    expect(loadingState.shouldShowLoading, true);
  });

  test("should not loading when loadStack = 0", () {
    LoadingState loadingState = const LoadingState(loadStack: 0);
    expect(loadingState.shouldShowLoading, false);
  });

  test("should not loading when loadStack < 0", () {
    LoadingState loadingState = const LoadingState(loadStack: -1);
    expect(loadingState.shouldShowLoading, false);
  });

  test("copyWith null loadStack", () {
    const loadStackCount = -1;
    LoadingState loadingState = const LoadingState(loadStack: loadStackCount);

    loadingState = loadingState.copyWith();
    expect(loadingState.loadStack, loadStackCount);
  });

  test("copyWith amount loadStack", () {
    const initialCount = 5;
    const expectedCount = 10;
    LoadingState loadingState = const LoadingState(loadStack: initialCount);

    loadingState = loadingState.copyWith(loadStack: 10);
    expect(loadingState.loadStack, expectedCount);
  });
}
