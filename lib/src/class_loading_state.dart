class LoadingState {
  const LoadingState({this.loadStack = 0});

  final int loadStack;

  bool get shouldShowLoading => loadStack > 0;

  LoadingState copyWith({
    int? loadStack,
  }) {
    return LoadingState(
      loadStack: loadStack ?? this.loadStack,
    );
  }
}
