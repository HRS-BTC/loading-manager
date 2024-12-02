import 'package:flutter/material.dart';
import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/src/default_loading_manager.dart';
import 'package:loading_manager/src/loading_provider.dart';

class DefaultLoadingProvider extends SingleChildStatelessWidget {
  const DefaultLoadingProvider({super.key});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LoadingProvider(
      create: (_) => DefaultLoadingManager(),
      child: child,
    );
  }
}
