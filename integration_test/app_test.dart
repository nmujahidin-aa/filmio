import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:filmio/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Full Flow: Login → List → Detail → Rent",
      (tester) async {

    app.main();

    // Wait full initialization (Firebase + GetX)
    await tester.pump(const Duration(seconds: 3));

    // Pastikan Login screen muncul dulu
    expect(find.text("Login"), findsOneWidget);

    // Cari TextField dengan lebih aman
    final emailField = find.byType(TextField).at(0);
    final passwordField = find.byType(TextField).at(1);

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    await tester.enterText(emailField, "mujah@gmail.com");
    await tester.enterText(passwordField, "password");

    await tester.tap(find.text("Login"));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text("Filmio"), findsOneWidget);
  });
}
