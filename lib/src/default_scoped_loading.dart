import 'package:flutter/material.dart';
import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/loading_manager.dart';

class DefaultScopedLoading extends SingleChildStatelessWidget {
  const DefaultScopedLoading({
    super.key,
    super.child,
    this.performBuildLoading,
    this.performHandleLoading,
  });

  final void Function(BuildContext context, LoadingState state)?
      performHandleLoading;
  final Widget Function(BuildContext context, LoadingState state, Widget child)?
      performBuildLoading;

  SingleChildWidget buildProvider(BuildContext context) {
    return const DefaultLoadingProvider();
  }

  SingleChildWidget buildHandler(BuildContext context) {
    return DefaultLoadingHandler(
      performBuildLoading: performBuildLoading,
      performHandleLoading: performHandleLoading,
    );
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Nested(
      children: [
        buildProvider(context),
        buildHandler(context),
      ],
      child: child,
    );
  }
}
