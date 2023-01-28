import 'package:flutter/material.dart';
import 'package:my_best_food/features/styles/styles.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    required this.setIndex0,
    required this.setIndex1,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  final Function setIndex0;
  final Function setIndex1;
  final dynamic currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ItemColor.itemBlack54,
      elevation: 0.5,
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.list,
                color: currentIndex == 0
                    ? ItemColor.itemOrange1
                    : ItemColor.itemWhite,
                size: 24,
              ),
              onPressed: () {
                setIndex0();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: currentIndex == 1
                    ? ItemColor.itemOrange1
                    : ItemColor.itemWhite,
                size: 24,
              ),
              onPressed: () {
                setIndex1();
              },
            ),
          ],
        ),
      ),
    );
  }
}
