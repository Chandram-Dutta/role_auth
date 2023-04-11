import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> createAccountWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> logout();
  User? get currentUser;
}
