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
}
