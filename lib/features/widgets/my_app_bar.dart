import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/styles/styles.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.currentIndex,
    required this.title,
    required this.appBar,
    required this.actions,
  }) : super(key: key);

  final int currentIndex;
  final String title;
  final AppBar appBar;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: ItemColor.itemWhite,
      ),
      title: Text(
        title,
        style: currentIndex == 0
            ? GoogleFonts.kanit(
                fontSize: 24,
                color: ItemColor.itemOrange1,
              )
            : GoogleFonts.kanit(
                fontSize: 22,
                color: ItemColor.itemWhite,
              ),
      ),
      actions: actions,
      backgroundColor: ItemColor.itemBlack54,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
