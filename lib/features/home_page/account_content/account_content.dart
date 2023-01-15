import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/app/cubit/root_cubit.dart';
import 'package:my_best_food/features/auth/login_page/cubit/login_cubit.dart';

class AccountPageContent extends StatelessWidget {
  const AccountPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      const Text('Jesteś zalogowany jako'),
                      Text('${state.user?.email}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginCubit>().signOut();
                  },
                  child: const Text('Wyloguj'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
