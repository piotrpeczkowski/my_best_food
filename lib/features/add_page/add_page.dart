import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/add_page/cubit/add_cubit.dart';
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
  String? _rank;

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
                title: const Text('Dodaj nową pozycję'),
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
                    icon: const Icon(Icons.check),
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
                  });
                },
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
    Key? key,
  }) : super(key: key);

  final Function(String) onRestaurantChanged;
  final Function(String) onFoodChanged;
  final Function(String) onPriceChanged;
  final Function(String) onRankChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            onChanged: onRestaurantChanged,
            decoration: const InputDecoration(label: Text('Restauracja')),
          ),
          TextField(
            onChanged: onFoodChanged,
            decoration: const InputDecoration(label: Text('Nazwa potrawy')),
          ),
          TextField(
            onChanged: onPriceChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(label: Text('Koszt')),
          ),
          TextField(
            onChanged: onRankChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(label: Text('Ocena')),
          ),
        ],
      ),
    );
  }
}

  //   return BlocProvider(
  //     create: (context) => AddCubit(ItemsRepository()),
  //     child: BlocListener<AddCubit, AddState>(
  //       listener: (context, state) {
  //         if (state.saved) {
  //           Navigator.of(context).pop();
  //         }
  //         if (state.errorMessage.isNotEmpty) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text(state.errorMessage),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         }
  //       },
  //       child: BlocBuilder<AddCubit, AddState>(
  //         builder: (context, state) {
  //           return Scaffold(
  //             appBar: AppBar(
  //               title: const Text('Add new upcoming title'),
  //               actions: [
  //                 IconButton(
  //                   onPressed: _imageURL == null ||
  //                           _title == null ||
  //                           _releaseDate == null
  //                       ? null
  //                       : () {
  //                           context.read<AddCubit>().add(
  //                                 _title!,
  //                                 _imageURL!,
  //                                 _releaseDate!,
  //                               );
  //                         },
  //                   icon: const Icon(Icons.check),
  //                 ),
  //               ],
  //             ),
  //             body: _AddPageBody(
  //               onTitleChanged: (newValue) {
  //                 setState(() {
  //                   _title = newValue;
  //                 });
  //               },
  //               onImageUrlChanged: (newValue) {
  //                 setState(() {
  //                   _imageURL = newValue;
  //                 });
  //               },
  //               onDateChanged: (newValue) {
  //                 setState(() {
  //                   _releaseDate = newValue;
  //                 });
  //               },
  //               selectedDateFormatted: _releaseDate == null
  //                   ? null
  //                   : DateFormat.yMMMMEEEEd().format(_releaseDate!),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
// class _AddPageBody extends StatelessWidget {
//   const _AddPageBody({
//     Key? key,
//     required this.onTitleChanged,
//     required this.onImageUrlChanged,
//     required this.onDateChanged,
//     this.selectedDateFormatted,
//   }) : super(key: key);

//   final Function(String) onTitleChanged;
//   final Function(String) onImageUrlChanged;
//   final Function(DateTime?) onDateChanged;
//   final String? selectedDateFormatted;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 30,
//         vertical: 20,
//       ),
//       children: [
//         TextField(
//           onChanged: onTitleChanged,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'Matrix 5',
//             label: Text('Title'),
//           ),
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           onChanged: onImageUrlChanged,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'http:// ... .jpg',
//             label: Text('Image URL'),
//           ),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () async {
//             final selectedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(
//                 const Duration(days: 365 * 10),
//               ),
//             );
//             onDateChanged(selectedDate);
//           },
//           child: Text(selectedDateFormatted ?? 'Choose release date'),
//         ),
//       ],
//     );
//   }
// }