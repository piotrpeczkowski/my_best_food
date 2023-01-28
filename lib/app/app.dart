import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/app/cubit/root_cubit.dart';
import 'package:my_best_food/features/auth/login_page/pages/login_page.dart';
import 'package:my_best_food/features/home_page/pages/home_page.dart';
import 'package:my_best_food/features/splash_screen/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      theme: ThemeData(
        //useMaterial3: true,
        //colorSchemeSeed: Colors.blue,
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
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
          return HomePage(
            title: Strings.title,
            titleUser: Strings.titleUser,
            userEmail: '${state.user?.email}',
          );
        },
      ),
    );
  }
}

class Strings {
  static String title = 'myBestFood';
  static String titleUser = 'Profil użytkownika';
}
