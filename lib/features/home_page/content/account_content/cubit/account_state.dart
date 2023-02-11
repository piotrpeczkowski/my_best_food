part of 'account_cubit.dart';

class AccountState {
  const AccountState({
    this.infos = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });

  final List<UserModel> infos;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
}
