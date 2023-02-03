import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/user_page/cubit/user_cubit.dart';
import 'package:my_best_food/repositories/user_repository.dart';
import 'package:my_best_food/root/cubit/root_cubit.dart';
import 'package:my_best_food/features/styles/styles.dart';

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
                      BlocProvider(
                        create: (context) =>
                            UserCubit(UserRepository())..getUserInfoWithID(id),
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            final userImage = state.userModel?.imageUrl;
                            if (userImage == null || userImage == '') {
                              return const Opacity(
                                opacity: 0.3,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('images/account_avatar.png'),
                                ),
                              );
                            }
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(userImage),
                            );
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 20),
                            child: Text(
                              'Jesteś zalogowany jako:',
                              style: GoogleFonts.lato(
                                color: ItemColor.itemBlack87,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              // email of logged user
                              '${state.user?.email}',
                              style: GoogleFonts.lato(
                                color: ItemColor.itemBlack87,
                                fontSize: 18,
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
