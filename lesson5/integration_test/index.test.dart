import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lesson5/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration 測試', () {
    setUpAll(() async {
      await Future.delayed(const Duration(seconds: 5));
    });

    testWidgets('正常進入到登入頁', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('門市'), findsOneWidget);
      expect(find.text('員工編號'), findsOneWidget);
      expect(find.text('登入'), findsOneWidget);
      await Future.delayed(const Duration(seconds: 5));
    });
  });
}
