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

  Future<void> orderBy(int selectedItem) async {
    if (selectedItem == 0) {
      start(true, 'dateTime');
    } else if (selectedItem == 1) {
      start(false, 'dateTime');
    } else if (selectedItem == 2) {
      start(true, 'restaurant');
    } else if (selectedItem == 3) {
      start(false, 'restaurant');
    } else if (selectedItem == 4) {
      start(true, 'rank');
    } else if (selectedItem == 5) {
      start(false, 'rank');
    } else if (selectedItem == 6) {
      start(true, 'price');
    } else {
      start(false, 'price');
    }
  }

  Future<void> start(
    bool isDescending,
    String orderBy,
  ) async {
    _streamSubscription?.cancel();
    _streamSubscription =
        _itemsRepository.getItemsStream(isDescending, orderBy).listen(
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
      start(true, 'dateTime');
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
      start(true, 'dateTime');
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
