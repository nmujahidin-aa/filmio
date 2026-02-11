import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:filmio/modules/auth/controllers/auth_controller.dart';
import 'package:filmio/core/services/firebase_service.dart';

class MockFirebaseService extends Mock implements FirebaseService {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late AuthController controller;
  late MockFirebaseService mockService;
  late MockUserCredential mockCredential;

  setUpAll(() {
    registerFallbackValue(MockUserCredential());
  });

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    mockService = MockFirebaseService();
    mockCredential = MockUserCredential();

    controller = AuthController(mockService);
  });

  test("Login success should call firebase service", () async {
    when(() => mockService.login(any(), any()))
        .thenAnswer((_) async => mockCredential);

    await controller.login("test@mail.com", "123456");

    verify(() => mockService.login("test@mail.com", "123456"))
        .called(1);
  });
}
