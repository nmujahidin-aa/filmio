import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:filmio/modules/auth/controllers/auth_controller.dart';
import 'package:filmio/core/services/firebase_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  late AuthController controller;
  late MockFirebaseService mockService;

  setUp(() {
    Get.testMode = true;
    mockService = MockFirebaseService();
    controller = AuthController(mockService);
  });

  test("Initial user should be null", () {
    when(mockService.currentUser).thenReturn(null);
    controller.onInit();
    expect(controller.user.value, null);
  });

  test("Login success should call firebase service", () async {
    when(mockService.login("test@mail.com", "123456"))
        .thenAnswer((_) async => Future.value());

    await controller.login("test@mail.com", "123456");

    verify(mockService.login("test@mail.com", "123456")).called(1);
  });
}
