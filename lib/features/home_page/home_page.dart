import 'package:flutter/material.dart';
import 'package:my_best_food/features/home_page/account_content/account_content.dart';
import 'package:my_best_food/features/home_page/restaurant_content/restaurant_content.dart';
import 'package:my_best_food/features/widgets/my_app_bar.dart';
import 'package:my_best_food/features/widgets/my_bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        appBar: AppBar(),
      ),
      bottomNavigationBar: MyBottomAppBar(
        setIndex0: () {
          setState(() {
            _currentIndex = 0;
          });
        },
        setIndex1: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Builder(builder: (context) {
        if (_currentIndex == 0) {
          return const RestaurantPageContent();
        }
        return const AccountPageContent();
      }),
    );
  }
}
