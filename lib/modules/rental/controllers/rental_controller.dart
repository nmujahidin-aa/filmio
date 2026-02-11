import 'package:get/get.dart';
import '../../../data/models/rental_model.dart';
import '../../../data/repositories/rental_repository.dart';

class RentalController extends GetxController {
  final RentalRepository repository;

  RentalController(this.repository);

  var rentals = <RentalModel>[].obs;
  var totalCost = 0.obs;
  var preferredKeyword = "".obs;

  @override
  void onInit() {
    fetchRentals();
    super.onInit();
  }

  Future<void> rentMovie(RentalModel rental) async {
    await repository.saveRental(rental);

    print("=== TRANSACTION SAVED ===");
    print(rental.toJson());

    fetchRentals();
  }

  Future<void> fetchRentals() async {
    final result = await repository.getRentals();
    rentals.value = result;
    calculateTotal();
  }

  void calculateTotal() {
    totalCost.value =
        rentals.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void updatePreference(String title) {
    preferredKeyword.value =
        title.split(" ").first.toLowerCase();
  }
}
