import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/home_page/content/account_content/cubit/account_cubit.dart';
import 'package:my_best_food/repositories/user_repository.dart';
import 'package:my_best_food/root/cubit/root_cubit.dart';
import 'package:my_best_food/features/styles/styles.dart';

class AccountPageContent extends StatelessWidget {
  const AccountPageContent({
    required this.id,
    required this.userEmail,
    Key? key,
  }) : super(key: key);

  final String id;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(UserRepository())..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: BlocBuilder<AccountCubit, AccountState>(
                    builder: (context, state) {
                      final userModels = state.infos;
                      if (userModels.isEmpty) {
                        return const Center(
                          child: Text('Brak elementów do wyświetlenia'),
                        );
                      }
                      return Column(
                        children: [
                          for (final userModel in userModels) ...[
                            Container(
                              color: ItemColor.itemBlack12,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                top: 30,
                                bottom: 15,
                              ),
                              child: Column(
                                children: [
                                  userModel.imageUrl.isEmpty
                                      ? const Opacity(
                                          opacity: 0.3,
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                                'images/account_avatar.png'),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              NetworkImage(userModel.imageUrl),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Text(
                                      userEmail,
                                      style: GoogleFonts.lato(
                                        color: ItemColor.itemBlack87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Nazwa:  ${userModel.userName}',
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
                                      'Miasto:  ${userModel.userCity}',
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
                                      'Płeć:  ${userModel.userGender}',
                                      style: GoogleFonts.lato(
                                        color: ItemColor.itemBlack87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                      );
                    },
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
