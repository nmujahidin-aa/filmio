import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:filmio/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Full Flow: Login → List → Detail → Rent",
      (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextField).first, "test@mail.com");
    await tester.enterText(
        find.byType(TextField).last, "123456");

    await tester.tap(find.text("Login"));
    await tester.pumpAndSettle();

    expect(find.text("Movies"), findsOneWidget);
  });
}
