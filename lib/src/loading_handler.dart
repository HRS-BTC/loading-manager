import 'package:flutter/material.dart';
import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/src/class_loading_state.dart';

import 'loading_manager.dart';

abstract class LoadingHandler<T extends LoadingManager>
    extends SingleChildStatelessWidget {
  const LoadingHandler({super.key, super.child});

  T getLoadingManager(BuildContext context) {
    return context.read<T>();
  }

  void handleLoading(BuildContext context, LoadingState state);

  Widget buildLoading(BuildContext context, LoadingState state, Widget child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(child != null);
    return RxConsumer<LoadingState>(
      listener: handleLoading,
      subjectGetter: (BuildContext context) {
        return getLoadingManager(context).stateChangedSubject;
      },
      builder: (BuildContext context, LoadingState state) {
        return buildLoading(context, state, child!);
      },
    );
  }
}
