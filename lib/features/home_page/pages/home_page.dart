import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/add_page/pages/add_page.dart';
import 'package:my_best_food/features/auth/login_page/cubit/login_cubit.dart';
import 'package:my_best_food/features/home_page/content/account_content/account_content.dart';
import 'package:my_best_food/features/home_page/content/restaurant_content/restaurant_content.dart';
import 'package:my_best_food/features/user_page/cubit/user_cubit.dart';
import 'package:my_best_food/features/user_page/pages/user_page.dart';
import 'package:my_best_food/features/widgets/my_app_bar.dart';
import 'package:my_best_food/features/widgets/my_bottom_app_bar.dart';
import 'package:my_best_food/features/widgets/order_popup_menu.dart';
import 'package:my_best_food/repositories/auth_repository.dart';
import 'package:my_best_food/repositories/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.title,
    required this.titleUser,
    required this.userEmail,
    Key? key,
  }) : super(key: key);

  final String userEmail; // user email from root page
  final String title; // main title of app
  final String titleUser; // title of user profile screen

  // name of constant firebase collection for user informations
  final userProfile = 'userProfile';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex =
      0; // variable which specifies screen to display (like a switch)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
        title: _currentIndex == 0 ? widget.title : widget.titleUser,
        actions: [
          Builder(builder: (context) {
            // AppBar Icon for list screen
            if (_currentIndex == 0) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: OrderPopupMenu(),
              ));
            }
            // AppBar Icon for account  screen
            if (_currentIndex == 1) {
              return BlocProvider(
                create: (context) => UserCubit(UserRepository()),
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              id: widget.userProfile,
                              userEmail: widget.userEmail,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.settings),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(
        currentIndex: _currentIndex,
        setIndex0: () {
          setState(() {
            _currentIndex = 0; // to RestaurantContent
          });
        },
        setIndex1: () {
          setState(() {
            _currentIndex = 1; // to AccountContent
          });
        },
      ),
      floatingActionButton: Builder(builder: (context) {
        // action of adding new position when restaurant list is display
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
        // action of sign out when account screen is display
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
        return AccountPageContent(id: widget.userProfile);
      }),
    );
  }
}
