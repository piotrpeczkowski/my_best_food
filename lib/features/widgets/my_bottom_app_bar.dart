import 'package:flutter/material.dart';

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
      color: Colors.blue,
      elevation: 0.5,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.list,
                color: currentIndex == 0 ? Colors.orange : Colors.white,
                size: 24,
              ),
              onPressed: () {
                setIndex0();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: currentIndex == 1 ? Colors.orange : Colors.white,
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
