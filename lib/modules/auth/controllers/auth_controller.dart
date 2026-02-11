import 'package:get/get.dart';
import '../../../core/services/firebase_service.dart';
import '../../../core/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseService firebaseService;

  AuthController(this.firebaseService);

  var user = Rx<User?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    user.value = firebaseService.currentUser;
    super.onInit();
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      await firebaseService.register(email, password);
      Get.offAllNamed(AppPages.movies);
    } catch (e) {
      Get.snackbar("Register Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await firebaseService.login(email, password);
      Get.offAllNamed(AppPages.movies);
    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await firebaseService.logout();
    Get.offAllNamed(AppPages.login);
  }
}
