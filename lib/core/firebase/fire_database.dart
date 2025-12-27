import 'package:expense_tracker/core/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signUp(String name, String password, String email) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel userModel = UserModel(
      name: name,
      email: email,
      password: password,
      currency: "EGP",
    );
    await firestore
        .collection('Users')
        .doc(userCredential.user!.uid)
        .set(userModel.toJson());
  }

  Future<UserModel> login(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    try {
      DocumentSnapshot userDoc = await firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();
      return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error logging in user: $e');
    }
    return UserModel(email: '', password: '', name: '', currency: '',);
  }
}
