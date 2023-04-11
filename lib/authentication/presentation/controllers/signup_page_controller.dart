import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_auth/authentication/repository/auth_repository.dart';
import 'package:role_auth/authentication/repository/firebase_auth_repository.dart';

class SignupPageController extends StateNotifier<AsyncValue<void>> {
  SignupPageController({required this.authRepository})
      : super(const AsyncData<void>(null));
  final AuthRepository authRepository;

  Future<void> signup({
    required String email,
    required String password,
    required String type,
  }) async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard<void>(
      () => authRepository.createAccountWithEmailAndPassword(
        email,
        password,
        type,
      ),
    );
  }
}

final signupPageControllerProvider =
    StateNotifierProvider.autoDispose<SignupPageController, AsyncValue<void>>(
  (ref) {
    return SignupPageController(
      authRepository: ref.watch(firebaseAuthRepositoryProvider),
    );
  },
);
