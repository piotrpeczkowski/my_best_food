import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:my_best_food/models/user_model.dart';
import 'package:my_best_food/repositories/user_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._userRepository) : super(const AccountState());

  final UserRepository _userRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription?.cancel();
    _streamSubscription = _userRepository.getInfosStream().listen(
      (infos) {
        emit(AccountState(infos: infos));
      },
    )..onError(
        (error) {
          emit(const AccountState(loadingErrorOccured: true));
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
