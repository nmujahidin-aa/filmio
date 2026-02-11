import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => auth.currentUser;

  Future<UserCredential> register(
      String email, String password) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login(
      String email, String password) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> saveRental(
      String userId, Map<String, dynamic> data) async {
    await firestore
        .collection('rentals')
        .doc(userId)
        .collection('items')
        .add(data);
  }

  Future<List<QueryDocumentSnapshot>> getRentals(
      String userId) async {
    final snapshot = await firestore
        .collection('rentals')
        .doc(userId)
        .collection('items')
        .get();

    return snapshot.docs;
  }
}
