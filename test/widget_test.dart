import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animals/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exception.toString().contains('HTTP request failed') ||
          details.exception.toString().contains('statusCode: 400') ||
          details.exception.toString().contains('HttpClient')) {
        return;
      }
      originalOnError?.call(details);
    };

    await tester.pumpWidget(const AnimalsApp());
    expect(find.text('Animals-uz'), findsOneWidget);

    FlutterError.onError = originalOnError;
  });
}
