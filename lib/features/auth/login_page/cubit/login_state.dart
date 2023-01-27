part of 'login_cubit.dart';

@immutable
class LoginState {
  const LoginState({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
