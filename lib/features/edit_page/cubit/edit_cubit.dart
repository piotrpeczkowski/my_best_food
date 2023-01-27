import 'package:bloc/bloc.dart';
import 'package:my_best_food/models/item_model.dart';
import 'package:my_best_food/repositories/items_repository.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit(this._itemsRepository) : super(EditState(itemModel: null));

  final ItemsRepository _itemsRepository;

  Future<void> getItemWithID(String id) async {
    final itemModel = await _itemsRepository.get(id: id);
    emit(EditState(itemModel: itemModel));
  }

  Future<void> update(
    String id,
    String restaurant,
    String food,
    String price,
    double rank,
  ) async {
    try {
      await _itemsRepository.update(id, restaurant, food, price, rank);
      emit(EditState(saved: true));
    } catch (error) {
      emit(EditState(errorMessage: error.toString()));
    }
  }
}
