import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<void> register(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> resetPassword(
    String email,
  ) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).onError(
          (error, stackTrace) => null,
        );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
