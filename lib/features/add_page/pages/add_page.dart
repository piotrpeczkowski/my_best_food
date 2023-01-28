import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/add_page/cubit/add_cubit.dart';
import 'package:my_best_food/features/styles/styles.dart';
import 'package:my_best_food/repositories/items_repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final DateTime _dateTime = DateTime.now();
  String? _restaurant;
  String? _food;
  String? _price;
  double? _rank;
  var rank = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ItemsRepository()),
      child: BlocListener<AddCubit, AddState>(
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
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: ItemColor.itemWhite,
                ),
                backgroundColor: ItemColor.itemBlack54,
                title: Text(
                  'Dodaj nową pozycję',
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    color: ItemColor.itemWhite,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: _restaurant == null ||
                            _food == null ||
                            _price == null ||
                            _rank == null
                        ? null
                        : () {
                            context.read<AddCubit>().add(
                                  _dateTime,
                                  _restaurant!,
                                  _food!,
                                  _price!,
                                  _rank!,
                                );
                          },
                    icon: Icon(
                      Icons.check,
                      color: _restaurant == null ||
                              _food == null ||
                              _price == null ||
                              _rank == null
                          ? ItemColor.itemOrange1.withOpacity(0.5)
                          : ItemColor.itemOrange1,
                    ),
                  ),
                ],
              ),
              body: _AddPageBody(
                onRestaurantChanged: (newValue) {
                  setState(() {
                    _restaurant = newValue;
                  });
                },
                onFoodChanged: (newValue) {
                  setState(() {
                    _food = newValue;
                  });
                },
                onPriceChanged: (newValue) {
                  setState(() {
                    _price = newValue;
                  });
                },
                onRankChanged: (newValue) {
                  setState(() {
                    _rank = newValue;
                    rank = newValue;
                  });
                },
                rating: rank,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody({
    required this.onRestaurantChanged,
    required this.onFoodChanged,
    required this.onPriceChanged,
    required this.onRankChanged,
    required this.rating,
    Key? key,
  }) : super(key: key);

  final Function(String) onRestaurantChanged;
  final Function(String) onFoodChanged;
  final Function(String) onPriceChanged;
  final Function(double) onRankChanged;
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
                  label: const Text('Restauracja'),
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
                  label: const Text('Nazwa potrawy'),
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
                inputFormatters: const [
                  PosInputFormatter(),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  label: const Text('Koszt'),
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
