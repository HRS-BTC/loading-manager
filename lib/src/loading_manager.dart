import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/src/exceptions.dart';
import 'package:loading_manager/src/loading_state.dart';

abstract class LoadingManager extends BaseViewModel<LoadingState> {
  @override
  void init() {
    initLoadingManager();
    super.init();
  }

  @protected
  @visibleForTesting
  void initLoadingManager() {
    reset();
  }

  Future<T> pushFuture<T>({required Future<T> future}) async {
    pushAmount(amount: 1);
    await future;
    pushAmount(amount: -1);
    return future;
  }

  @override
  LoadingState get state {
    if (!stateChangedSubject.hasValue) {
      throw const LoadingManagerNotInitialized();
    }
    return super.state;
  }

  void push({int amount = 1}) {
    assert(amount > 0);
    pushAmount(amount: amount);
  }

  void pop({int amount = 1}) {
    assert(amount > 0);
    pushAmount(amount: -amount);
  }

  @visibleForTesting
  void pushAmount({required int amount}) {
    LoadingState currentState = state;
    stateChangedSubject.add(
      currentState.copyWith(
        loadStack: max(0, currentState.loadStack + amount),
      ),
    );
    assert(state.loadStack >= 0);
  }

  void clear() {
    reset();
  }

  @protected
  @visibleForTesting
  void reset() {
    stateChangedSubject.add(const LoadingState());
  }
}
