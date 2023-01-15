import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_best_food/repositories/items_repository.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRepository) : super(const AddState());

  final ItemsRepository _itemsRepository;

  Future<void> add(
    DateTime dateTime,
    String restaurant,
    String food,
    String price,
    String rank,
  ) async {
    try {
      await _itemsRepository.add(dateTime, restaurant, food, price, rank);
      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
