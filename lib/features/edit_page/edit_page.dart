import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/edit_page/cubit/edit_cubit.dart';
import 'package:my_best_food/repositories/items_repository.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? _restaurant;
  String? _food;
  String? _price;
  double? _rank;
  var rank = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditCubit(ItemsRepository())..getItemWithID(widget.id),
      child: BlocListener<EditCubit, EditState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<EditCubit, EditState>(
          builder: (context, state) {
            final itemModel = state.itemModel;
            if (itemModel == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Edytuj pozycję'),
                actions: [
                  IconButton(
                    onPressed:
                        _restaurant == null || _food == null || _price == null
                            ? null
                            : () {
                                context.read<EditCubit>().update(
                                      widget.id,
                                      _restaurant!,
                                      _food!,
                                      _price!,
                                      _rank!,
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 4),
                                    content: Text('Zaktualizowano'),
                                  ),
                                );
                              },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: _EditPageBody(
                restaurantLabel: itemModel.restaurant,
                onRestaurantChanged: (newValue) {
                  setState(() {
                    _restaurant = newValue;
                  });
                },
                foodLabel: itemModel.food,
                onFoodChanged: (newValue) {
                  setState(() {
                    _food = newValue;
                  });
                },
                priceLabel: itemModel.price,
                onPriceChanged: (newValue) {
                  setState(() {
                    _price = newValue;
                  });
                },
                rankLabel: itemModel.rank.toString(),
                onRankChanged: (newValue) {
                  setState(() {
                    _rank = newValue;
                    rank = newValue;
                  });
                },
                rating: itemModel.rank,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EditPageBody extends StatelessWidget {
  const _EditPageBody({
    required this.onRestaurantChanged,
    required this.restaurantLabel,
    required this.onFoodChanged,
    required this.foodLabel,
    required this.onPriceChanged,
    required this.priceLabel,
    required this.onRankChanged,
    required this.rankLabel,
    required this.rating,
    Key? key,
  }) : super(key: key);

  final Function(String) onRestaurantChanged;
  final String restaurantLabel;
  final Function(String) onFoodChanged;
  final String foodLabel;
  final Function(String) onPriceChanged;
  final String priceLabel;
  final Function(double) onRankChanged;
  final String rankLabel;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // RESTAURANT TextField
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextField(
                onChanged: onRestaurantChanged,
                decoration: InputDecoration(
                  label: Text(restaurantLabel),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            // FOOD TextField
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextField(
                onChanged: onFoodChanged,
                decoration: InputDecoration(
                  label: Text(foodLabel),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            // PRICE TextField
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextField(
                onChanged: onPriceChanged,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  label: Text(priceLabel),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            // RANK Slider
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Slider(
                label: rating.toString(),
                value: rating,
                onChanged: onRankChanged,
                min: 1,
                max: 5,
                divisions: 8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Ocena:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Text(
                    rating.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: rating >= 4.5
                            ? const Color.fromARGB(255, 0, 143, 5)
                            : rating <= 2.5
                                ? Colors.red
                                : Colors.black),
                  ),
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
