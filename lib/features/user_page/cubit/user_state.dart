part of 'user_cubit.dart';

@immutable
class UserState {
  const UserState({
    this.userModel,
    this.saved = false,
    this.errorMessage = '',
  });

  final UserModel? userModel;
  final bool saved;
  final String errorMessage;
}
