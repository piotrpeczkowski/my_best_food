import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/user_page/cubit/user_cubit.dart';
import 'package:my_best_food/repositories/user_repository.dart';

Future<void> imageSourceDialog(
  BuildContext context,
  String id,
  String imageUrl,
  Function openCamera,
  Function openGallery,
) async {
  showDialog(
    context: context,
    builder: (BuildContext context) => BlocProvider(
      create: (context) => UserCubit(UserRepository())..getUserInfoWithID(id),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return SimpleDialog(
            title: Text(
              'Zrób zdjęcie',
              style: GoogleFonts.kanit(),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      openCamera();
                    },
                    child: Text(
                      'Otwórz aparat',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      openGallery();
                    },
                    child: Text(
                      'Otwórz Galerię',
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                      ),
                    )),
              ),
            ],
          );
        },
      ),
    ),
  );
}
