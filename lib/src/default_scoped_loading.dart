import 'package:flutter/material.dart';
import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/loading_manager.dart';

class DefaultScopedLoading extends SingleChildStatelessWidget {
  const DefaultScopedLoading({super.key});

  SingleChildWidget buildProvider(BuildContext context) {
    return const DefaultLoadingProvider();
  }

  SingleChildWidget buildHandler(BuildContext context) {
    return const DefaultLoadingHandler();
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
