import 'package:flutter/material.dart';
import 'package:my_best_food/features/home_page/account_content/account_content.dart';
import 'package:my_best_food/features/widgets/my_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        appBar: AppBar(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lista'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Konto'),
        ],
      ),
      body: const AccountPageContent(),
    );
  }
}
