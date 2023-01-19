import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/edit_page/cubit/edit_cubit.dart';
import 'package:my_best_food/repositories/items_repository.dart';

class EditPage extends StatefulWidget {
  EditPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  final TextEditingController _restaurantController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  double? _rating;
  var _rank = 1.0;

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
            if (itemModel != null) {
              widget._restaurantController.text = itemModel.restaurant;
              widget._foodController.text = itemModel.food;
              widget._priceController.text = itemModel.price;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Edytuj pozycję'),
                  actions: [
                    IconButton(
                      onPressed: widget._restaurantController.text == '' ||
                              widget._foodController.text == '' ||
                              widget._priceController.text == '' ||
                              _rating == null
                          ? null
                          : () {
                              context.read<EditCubit>().update(
                                    widget.id,
                                    widget._restaurantController.text,
                                    widget._foodController.text,
                                    widget._priceController.text,
                                    _rank,
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
                  // for restaurant elements
                  restaurantLabel: 'Restauracja',
                  restaurantController: widget._restaurantController,
                  // for food elements
                  foodLabel: 'Jedzenie',
                  foodController: widget._foodController,
                  // for price elements
                  priceLabel: 'Koszt',
                  priceController: widget._priceController,
                  // for rank elements
                  rankLabel: _rank.toString(),
                  onRankChanged: (newValue) {
                    setState(() {
                      _rank = newValue;
                      _rating = newValue;
                    });
                  },
                  rankValue: _rank,
                  ratingValue: _rating,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _EditPageBody extends StatelessWidget {
  const _EditPageBody({
    required this.restaurantController,
    required this.restaurantLabel,
    required this.foodController,
    required this.foodLabel,
    required this.priceController,
    required this.priceLabel,
    required this.onRankChanged,
    required this.rankLabel,
    required this.rankValue,
    required this.ratingValue,
    Key? key,
  }) : super(key: key);

  final TextEditingController restaurantController;
  final String restaurantLabel;
  final TextEditingController foodController;
  final String foodLabel;
  final TextEditingController priceController;
  final String priceLabel;
  final Function(double) onRankChanged;
  final String rankLabel;
  final double rankValue;
  final double? ratingValue;

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
                controller: restaurantController,
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
                // onChanged: onFoodChanged,
                controller: foodController,
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
                // onChanged: onPriceChanged,
                controller: priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  label: Text(priceLabel),
                  suffixText: 'zł',
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
                label: rankValue.toString(),
                value: rankValue,
                onChanged: onRankChanged,
                min: 1,
                max: 5,
                divisions: 8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ratingValue == null
                    ? const Text(
                        'Ponownie ustaw ocenę!',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      )
                    : const Text(''),
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
                        rankValue.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: rankValue >= 4.5
                                ? const Color.fromARGB(255, 0, 143, 5)
                                : rankValue <= 2.5
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
          ],
        ),
      ),
    );
  }
}
