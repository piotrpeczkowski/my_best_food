import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:my_best_food/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository)
      : super(const LoginState(email: '', password: ''));

  final AuthRepository _authRepository;

  Future<void> register(
      {required String email, required String password}) async {
    await _authRepository.register(email, password);
  }

  Future<void> signIn({required String email, required String password}) async {
    await _authRepository.signIn(email, password);
  }

  Future<void> resetPassword({required String email}) async {
    await _authRepository.resetPassword(email);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
