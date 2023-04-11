import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_auth/authentication/repository/auth_repository.dart';

class FirebaseAuthRepository extends AuthRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> createAccountWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  User? get currentUser => firebaseAuth.currentUser;
}

final firebaseAuthRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository();
});
