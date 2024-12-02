class LoadingManagerNotInitialized implements Exception {
  const LoadingManagerNotInitialized();

  @override
  String toString() {
    return "[LoadingManagerNotInitialized] Loading manager not initialized";
  }
}
