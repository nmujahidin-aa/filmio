import 'package:get/get.dart';

import '../core/services/api_service.dart';
import '../core/services/firebase_service.dart';
import '../data/repositories/movie_repository.dart';
import '../data/repositories/rental_repository.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/movie/controllers/movie_controller.dart';
import '../modules/rental/controllers/rental_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(FirebaseService());

    Get.put(MovieRepository(Get.find()));
    Get.put(RentalRepository(Get.find()));

    Get.put(AuthController(Get.find()));
    Get.put(MovieController(Get.find()));
    Get.put(RentalController(Get.find()));
  }
}
