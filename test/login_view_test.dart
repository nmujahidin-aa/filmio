import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'package:filmio/modules/auth/views/login_view.dart';
import 'package:filmio/modules/auth/controllers/auth_controller.dart';
import 'package:filmio/core/services/firebase_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  late AuthController controller;
  late MockFirebaseService mockService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    mockService = MockFirebaseService();
    controller = AuthController(mockService);

    Get.put<AuthController>(controller);
  });

  testWidgets("Login view renders correctly", (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: LoginView(),
      ),
    );

    expect(find.text("Login"), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
