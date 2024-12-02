import 'package:flutter_test/flutter_test.dart';
import 'package:loading_manager/loading_manager.dart';

void main() {
  const exception = LoadingManagerNotInitialized();

  test("toString", () {
    final toString = exception.toString();
    expect(toString,
        "[LoadingManagerNotInitialized] Loading manager not initialized");
  });
}
