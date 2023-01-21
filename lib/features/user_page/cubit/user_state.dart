part of 'user_cubit.dart';

@immutable
class UserState {
  const UserState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}
