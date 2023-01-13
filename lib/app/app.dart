import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/app/cubit/root_cubit.dart';
import 'package:my_best_food/features/auth/login_page/login_page.dart';
import 'package:my_best_food/features/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return LoginPage();
          }
          return HomePage(title: Strings.title);
        },
      ),
    );
  }
}

class Strings {
  static String title = 'myBestFood';
}
