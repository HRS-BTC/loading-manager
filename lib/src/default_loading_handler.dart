import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_manager/src/class_loading_state.dart';
import 'package:loading_manager/src/loading_handler.dart';

class DefaultLoadingHandler extends LoadingHandler {
  const DefaultLoadingHandler({super.key, super.child});

  Widget renderPlatformSpecificLoader(
      BuildContext context, LoadingState state) {
    final renderLoading = state.shouldShowLoading;
    return Visibility(
      visible: renderLoading,
      child: Center(
        child: Platform.isIOS || Platform.isMacOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget buildLoading(BuildContext context, LoadingState state, Widget child) {
    return Stack(
      children: [
        child,
        renderPlatformSpecificLoader(context, state),
      ],
    );
  }

  @override
  void handleLoading(BuildContext context, LoadingState state) {}
}
