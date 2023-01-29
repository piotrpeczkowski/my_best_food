import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_best_food/models/user_model.dart';
import 'package:my_best_food/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(const UserState(userModel: null));

  final UserRepository _userRepository;

  Future<void> getUserInfoWithID(String id) async {
    final userModel = await _userRepository.get(id: id);
    emit(UserState(userModel: userModel));
  }

  Future<void> update(
    String id,
    String userName,
    String userCity,
    String userGender,
  ) async {
    try {
      await _userRepository.update(id, userName, userCity, userGender);
      emit(const UserState(saved: true));
    } catch (error) {
      emit(UserState(errorMessage: error.toString()));
    }
  }

  // Future pickImage(
  //   ImageSource source,
  //   File? imageFile,
  // ) async {
  //   await _userRepository.pickImage(source, imageFile);
  // }
}
