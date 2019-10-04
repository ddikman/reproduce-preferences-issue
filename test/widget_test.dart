import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:preferences/preference_service.dart';

import 'package:test_with_preference_service/main.dart';

void main() {
  testWidgets('Test that halts', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle(Duration(seconds: 10), EnginePhase.build);

      final text = tester.firstElement(find.byType(Text));
      expect(text.toString(), startsWith('MissingPluginException(No implementation found for method getAll'));
    });
  });

  test('Preferences not loaded', () async {
    await PrefService.init(prefix: 'test');
  });
}
