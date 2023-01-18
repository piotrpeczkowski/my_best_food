part of 'edit_cubit.dart';

class EditState {
  EditState({
    this.itemModel,
    this.saved = false,
    this.errorMessage = '',
  });

  final ItemModel? itemModel;
  final bool saved;
  final String errorMessage;
}
