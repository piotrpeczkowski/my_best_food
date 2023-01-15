import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/home_page/cubit/home_cubit.dart';
import 'package:my_best_food/features/widgets/item_widget.dart';
import 'package:my_best_food/repositories/items_repository.dart';

class RestaurantPageContent extends StatelessWidget {
  const RestaurantPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ItemsRepository())..start(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final itemModels = state.items;
          if (itemModels.isEmpty) {
            return const Center(
              child: Text('Brak elementów do wyświetlenia'),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            children: [
              for (final itemModel in itemModels)
                Dismissible(
                  key: ValueKey(itemModel.id),
                  background: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    // only from right to left
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) {
                    context.read<HomeCubit>().remove(documentID: itemModel.id);
                  },
                  child: ItemWidget(
                    itemModel: itemModel,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
