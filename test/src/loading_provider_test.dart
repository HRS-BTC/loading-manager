import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inherited_rxdart/inherited_rxdart.dart';
import 'package:loading_manager/loading_manager.dart';
import 'package:loading_manager/src/loading_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'loading_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoadingManager>()])
void main() {
  late LoadingManager manager;
  late BehaviorSubject<LoadingState> subject;

  setUp(() {
    manager = MockLoadingManager();
    subject = BehaviorSubject();
    when(manager.stateChangedSubject).thenAnswer((_) => subject);
  });

  testWidgets("create manager", (tester) async {
    await tester.pumpWidget(
      LoadingProvider(
        create: (context) {
          return manager;
        },
        child: const SizedBox(),
      ),
    );
    verify(manager.init()).called(1);
  });

  testWidgets("use managed manager ", (tester) async {
    await tester.pumpWidget(
      LoadingProvider.value(
        value: manager,
        child: const SizedBox(),
      ),
    );
    verifyNever(manager.init());
  });

  tearDown(() {
    subject.close();
  });
}
