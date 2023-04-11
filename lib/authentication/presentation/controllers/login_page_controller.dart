import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_auth/authentication/repository/auth_repository.dart';
import 'package:role_auth/authentication/repository/firebase_auth_repository.dart';

class LoginPageController extends StateNotifier<AsyncValue<void>> {
  LoginPageController({required this.authRepository})
      : super(const AsyncData<void>(null));
  final AuthRepository authRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => authRepository.signInWithEmailAndPassword(
        email,
        password,
      ),
    );
  }
}

final loginPageControllerProvider =
    StateNotifierProvider.autoDispose<LoginPageController, AsyncValue<void>>(
  (ref) {
    return LoginPageController(
      authRepository: ref.watch(firebaseAuthRepositoryProvider),
    );
  },
);
