import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/firebase/fire_database.dart';
import 'package:expense_tracker/core/model/user.dart';
import 'package:expense_tracker/features/auth/cubit/state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FireDatabase _fireAuth = FireDatabase();

  Future<void> signUp(String name, String password, String email) async {
    emit(AuthLoading());
    try {
      await _fireAuth.signUp(name, password, email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final userInfo = await _fireAuth.login(email, password);
      emit(LoginSuccess(userInfo));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }


  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    emit(AuthLoading());
    try {
      await _fireAuth.updateUserProfile(name: name, email: email);
      final user = _fireAuth.auth.currentUser;
      DocumentSnapshot userDoc = await _fireAuth.firestore
          .collection('Users')
          .doc(user!.uid)
          .get();
      final userInfo = UserModel.fromJson(
        userDoc.data() as Map<String, dynamic>,
      );

      emit(LoginSuccess(userInfo)); 
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
