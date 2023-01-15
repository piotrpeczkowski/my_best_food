import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.restaurant,
    required this.food,
    required this.datetime,
    required this.price,
    required this.rank,
  }) : super(key: key);

  final String restaurant;
  final String food;
  final String datetime;
  final String price;
  final double rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
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
                  datetime,
                  // style:
                  //     GoogleFonts.lato(fontSize: 14, color: FontColor.black4),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          restaurant,
                          // style: GoogleFonts.lato(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.black87),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              food,
                              // style: GoogleFonts.lato(
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.normal,
                              //     color: Colors.black87),
                            ),
                          ),
                          Text(
                            price == '' ? '' : '| $price zł',
                            // style: GoogleFonts.lato(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black87),
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
                        rank.toString(),
                        // style: GoogleFonts.lato(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //     color: rank >= 4.5
                        //         ? const Color.fromARGB(255, 0, 143, 5)
                        //         : rank <= 2.5
                        //             ? Colors.red
                        //             : Colors.black87.withOpacity(0.8)),
                      ),
                    ),
                    const Icon(Icons.star_border),
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
