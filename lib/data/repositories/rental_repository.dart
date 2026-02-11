import '../../core/services/firebase_service.dart';
import '../models/rental_model.dart';

class RentalRepository {
  final FirebaseService firebaseService;

  RentalRepository(this.firebaseService);

  Future<void> saveRental(RentalModel rental) async {
    final user = firebaseService.currentUser;
    if (user == null) throw Exception("User not logged in");

    await firebaseService.saveRental(user.uid, rental.toJson());
  }

  Future<List<RentalModel>> getRentals() async {
    final user = firebaseService.currentUser;
    if (user == null) throw Exception("User not logged in");

    final docs = await firebaseService.getRentals(user.uid);

    return docs
        .map((doc) => RentalModel.fromJson(
              doc.data() as Map<String, dynamic>,
            ))
        .toList();
  }
}
