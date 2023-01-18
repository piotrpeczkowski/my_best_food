import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_best_food/models/item_model.dart';
import 'package:my_best_food/repositories/items_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._itemsRepository) : super(const HomeState());

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (items) {
        emit(HomeState(items: items));
      },
    )..onError(
        (error) {
          emit(const HomeState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        const HomeState(removingErrorOccured: true),
      );
      start();
    }
  }

  Future<void> addToArchive({
    required DateTime dateTime,
    required String restaurant,
    required String food,
    required String price,
    required double rank,
  }) async {
    try {
      await _itemsRepository.addToArchive(
        dateTime,
        restaurant,
        food,
        price,
        rank,
      );
    } catch (error) {
      emit(
        const HomeState(removingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
