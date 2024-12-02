import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/src/loading_manager.dart';

class LoadingProvider<T extends LoadingManager> extends ViewModelProvider<T> {
  const LoadingProvider({super.key, required super.create, super.child});

  const LoadingProvider.value({required super.value, super.child, super.key})
      : super.value();
}
