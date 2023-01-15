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
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Jesteś zalogowany jako:'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('${state.user?.email}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
