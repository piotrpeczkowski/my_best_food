part of 'home_cubit.dart';

@immutable
class HomeState {
  const HomeState({
    this.items = const [],
    this.loadingErrorOccured = false,
    this.removingErrorMessage = false,
  });

  final List<ItemModel> items;
  final bool loadingErrorOccured;
  final bool removingErrorMessage;
}
