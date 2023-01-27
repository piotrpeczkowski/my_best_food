import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/app/cubit/root_cubit.dart';

class AccountPageContent extends StatelessWidget {
  const AccountPageContent({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

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
                          // default image for user avatar
                          // TODO: implement user avatar display from DB
                          backgroundImage:
                              AssetImage('images/account_avatar.png'),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 20),
                            child: Text('Jesteś zalogowany jako:'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              // email of logged user
                              '${state.user?.email}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // TODO: add saved info from userProfile collection
                        ],
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
