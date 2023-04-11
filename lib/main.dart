import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_auth/authentication/presentation/pages/login_page.dart';
import 'package:role_auth/authentication/repository/firebase_auth_repository.dart';
import 'package:role_auth/firebase_options.dart';
import 'package:role_auth/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Role Based Auth',
      theme: FlexThemeData.light(
        // lightIsWhite: true,
        useMaterial3: true,
        scheme: FlexScheme.redM3,
      ),
      darkTheme: FlexThemeData.dark(
        // darkIsTrueBlack: true,
        useMaterial3: true,
        scheme: FlexScheme.redM3,
      ),
      home: ref.watch(firebaseAuthRepositoryProvider).currentUser == null
          ? const LoginPage()
          : const HomePage(),
    );
  }
}
