import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/edit_page/edit_page_test.dart';
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
                  // background when you swipe from start to end
                  background: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                  // background when you swipe from end to start
                  secondaryBackground: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.archive,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      // just delete an item from collection
                      context
                          .read<HomeCubit>()
                          .remove(documentID: itemModel.id);
                      // message about delete an item from collection
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 4),
                          content: Text('Usunięto'),
                        ),
                      );
                    } else {
                      // move item to archive collection "archiveItems"
                      context.read<HomeCubit>().addToArchive(
                            dateTime: itemModel.dateTime,
                            restaurant: itemModel.restaurant,
                            food: itemModel.food,
                            price: itemModel.price,
                            rank: itemModel.rank,
                          );
                      // delete an item from previous collection "items"
                      context
                          .read<HomeCubit>()
                          .remove(documentID: itemModel.id);
                      // message about adding an item to the archive
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 4),
                          content: Text('Zarchiwizowano'),
                        ),
                      );
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      // message about how to enter to edit item
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 4),
                          content: Text('Przytrzymaj dłużej żeby edytować'),
                        ),
                      );
                    },
                    onLongPress: () {
                      // navigate to edit page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPage(id: itemModel.id),
                        ),
                      );
                    },
                    child: ItemWidget(
                      itemModel: itemModel,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
