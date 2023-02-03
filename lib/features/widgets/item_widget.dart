import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/styles/styles.dart';
import 'package:my_best_food/models/item_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ItemColor.itemWhite.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.95),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(2.5),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemModel.dateTimeFormatted(),
                  style: GoogleFonts.lato(
                    color: ItemColor.itemBlack54,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          itemModel.restaurant,
                          style: GoogleFonts.lato(
                            color: ItemColor.itemBlack87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              itemModel.food,
                              style: GoogleFonts.lato(
                                color: ItemColor.itemBlack87,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Text(
                            itemModel.price == ''
                                ? ''
                                : '| ${itemModel.price} zł',
                            style: GoogleFonts.lato(
                              color: ItemColor.itemBlack87,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        itemModel.rank.toString(),
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: itemModel.rank >= 4.5
                                ? const Color.fromARGB(255, 0, 143, 5)
                                : itemModel.rank <= 2.5
                                    ? ItemColor.itemRed
                                    : ItemColor.itemBlack87.withOpacity(0.8)),
                      ),
                    ),
                    const Icon(
                      Icons.star_border,
                      color: ItemColor.itemBlack54,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
