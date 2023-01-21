import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/app/cubit/root_cubit.dart';

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
                      const Opacity(
                        opacity: 0.3,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('images/account_avatar.png'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0, top: 20),
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
