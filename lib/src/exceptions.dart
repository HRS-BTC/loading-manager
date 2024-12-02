class LoadingManagerNotInitialized implements Exception {
  const LoadingManagerNotInitialized();

  @override
  String toString() {
    return "Loading manager not initialized";
  }
}
