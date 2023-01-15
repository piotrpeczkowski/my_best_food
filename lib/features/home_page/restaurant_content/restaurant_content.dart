import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/auth/login_page/cubit/login_cubit.dart';
import 'package:my_best_food/repositories/auth_repository.dart';

class RestaurantPageContent extends StatelessWidget {
  const RestaurantPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepository()),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Lista pozycji'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
