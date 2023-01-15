import 'package:intl/intl.dart';

class ItemModel {
  const ItemModel({
    required this.id,
    required this.dateTime,
    required this.restaurant,
    required this.food,
    required this.price,
    required this.rank,
  });
  final String id;
  final DateTime dateTime;
  final String restaurant;
  final String food;
  final double price;
  final double rank;

  String dateTimeFormatted() {
    return DateFormat.yMMMMEEEEd().format(dateTime);
  }
}
