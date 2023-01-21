import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_best_food/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(const UserState());

  final UserRepository _userRepository;
}
