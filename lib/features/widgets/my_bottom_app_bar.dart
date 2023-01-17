import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    required this.setIndex0,
    required this.setIndex1,
    Key? key,
  }) : super(key: key);

  final Function setIndex0;
  final Function setIndex1;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.list,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {
                    setIndex0();
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 26,
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
