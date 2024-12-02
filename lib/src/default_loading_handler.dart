import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_manager/src/default_loading_manager.dart';
import 'package:loading_manager/src/loading_state.dart';
import 'package:loading_manager/src/loading_handler.dart';

class DefaultLoadingHandler extends LoadingHandler<DefaultLoadingManager> {
  const DefaultLoadingHandler({
    super.key,
    super.child,
    this.performHandleLoading,
    this.performBuildLoading,
  });

  final void Function(BuildContext context, LoadingState state)?
      performHandleLoading;
  final Widget Function(BuildContext context, LoadingState state, Widget child)?
      performBuildLoading;

  Widget renderPlatformSpecificLoader(
      BuildContext context, LoadingState state) {
    final shouldShowLoading = state.shouldShowLoading;
    return Visibility(
      visible: shouldShowLoading,
      child: Center(
        child: defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget buildLoading(BuildContext context, LoadingState state, Widget child) {
    if (performBuildLoading != null) {
      return performBuildLoading?.call(context, state, child) ??
          const SizedBox.shrink();
    }
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: renderPlatformSpecificLoader(context, state),
          ),
        ],
      ),
    );
  }

  @override
  void handleLoading(BuildContext context, LoadingState state) {
    performHandleLoading?.call(context, state);
  }
}
