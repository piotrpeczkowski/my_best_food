import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/add_page/add_page.dart';
import 'package:my_best_food/features/auth/login_page/cubit/login_cubit.dart';
import 'package:my_best_food/features/home_page/account_content/account_content.dart';
import 'package:my_best_food/features/home_page/restaurant_content/restaurant_content.dart';
import 'package:my_best_food/features/widgets/my_app_bar.dart';
import 'package:my_best_food/features/widgets/my_bottom_app_bar.dart';
import 'package:my_best_food/repositories/auth_repository.dart';

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
      floatingActionButton: Builder(builder: (context) {
        if (_currentIndex == 0) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPage(),
                ),
              );
            },
            child: const Icon(Icons.add),
          );
        }
        return BlocProvider(
          create: (context) => LoginCubit(AuthRepository()),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return FloatingActionButton(
                onPressed: () {
                  context.read<LoginCubit>().signOut();
                },
                child: const Icon(Icons.logout),
              );
            },
          ),
        );
      }),
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
