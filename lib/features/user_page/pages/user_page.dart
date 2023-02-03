import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_best_food/features/styles/styles.dart';
import 'package:my_best_food/features/user_page/cubit/user_cubit.dart';
import 'package:my_best_food/features/widgets/camera_simple_dialog.dart';
import 'package:my_best_food/repositories/user_repository.dart';

class UserPage extends StatefulWidget {
  UserPage({
    required this.id,
    required this.userEmail,
    Key? key,
  }) : super(key: key);

  final String id;
  final String userEmail;

  // Controllers for user data fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userCityController = TextEditingController();
  final TextEditingController _userGenderController = TextEditingController();

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit(UserRepository())..getUserInfoWithID(widget.id),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.saved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 4),
                content: Text('Zapisano'),
              ),
            );
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final userModel = state.userModel;
            if (userModel != null) {
              widget._userNameController.text = userModel.userName;
              widget._userCityController.text = userModel.userCity;
              widget._userGenderController.text = userModel.userGender;
              //------------------------------------------------------
              // Screen with data when userModel isn't null in firebase
              //------------------------------------------------------
              return Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: ItemColor.itemWhite,
                  ),
                  backgroundColor: ItemColor.itemBlack54,
                  title: Text(
                    'Edytuj profil',
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      color: ItemColor.itemWhite,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<UserCubit>().update(
                              widget.id,
                              widget._userNameController.text,
                              widget._userCityController.text,
                              widget._userGenderController.text,
                            );
                      },
                      icon: const Icon(
                        Icons.check,
                        color: ItemColor.itemOrange1,
                      ),
                    ),
                  ],
                ),
                body: _UserPageBody(
                  id: widget.id,
                  imageUrl: imageUrl,
                  openCamera: () {
                    context.read<UserCubit>().pickAndUploadImage(
                          widget.id,
                          imageUrl,
                          ImageSource.camera,
                        );
                  },
                  openGallery: () {
                    context.read<UserCubit>().pickAndUploadImage(
                          widget.id,
                          imageUrl,
                          ImageSource.gallery,
                        );
                  },
                  userEmail: userModel.email,
                  userNameLabel: 'Nazwa użytkownika',
                  userNameController: widget._userNameController,
                  userCityLabel: 'Wybierz miasto',
                  userCityController: widget._userCityController,
                  userGenderLabel: 'Wybierz płeć',
                  userGenderController: widget._userGenderController,
                ),
              );
            }
            //------------------------------------------------------
            // Screen without user data when userModel is null in firebase
            //------------------------------------------------------
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: ItemColor.itemWhite,
                ),
                backgroundColor: ItemColor.itemBlack54,
                title: Text(
                  'Edytuj profil',
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    color: ItemColor.itemWhite,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<UserCubit>().update(
                            widget.id,
                            widget._userNameController.text,
                            widget._userCityController.text,
                            widget._userGenderController.text,
                          );
                    },
                    icon: const Icon(
                      Icons.check,
                      color: ItemColor.itemWhite,
                    ),
                  ),
                ],
              ),
              body: _UserPageBody(
                id: widget.id,
                imageUrl: imageUrl,
                openCamera: () {
                  context.read<UserCubit>().pickAndUploadImage(
                        widget.id,
                        imageUrl,
                        ImageSource.camera,
                      );
                },
                openGallery: () {
                  context.read<UserCubit>().pickAndUploadImage(
                        widget.id,
                        imageUrl,
                        ImageSource.gallery,
                      );
                },
                userEmail: widget.userEmail,
                userNameLabel: 'Nazwa użytkownika',
                userNameController: widget._userNameController,
                userCityLabel: 'Wybierz miasto',
                userCityController: widget._userCityController,
                userGenderLabel: 'Wybierz płeć',
                userGenderController: widget._userGenderController,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _UserPageBody extends StatelessWidget {
  const _UserPageBody({
    required this.openCamera,
    required this.openGallery,
    required this.userNameController,
    required this.userCityController,
    required this.userGenderController,
    required this.userNameLabel,
    required this.userCityLabel,
    required this.userGenderLabel,
    required this.userEmail,
    required this.imageUrl,
    required this.id,
    Key? key,
  }) : super(key: key);

  final Function openCamera;
  final Function openGallery;
  final TextEditingController userNameController;
  final TextEditingController userCityController;
  final TextEditingController userGenderController;
  final String userNameLabel;
  final String userCityLabel;
  final String userGenderLabel;
  final String userEmail;
  final String imageUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 35),
                      child: state.userModel?.imageUrl == null ||
                              state.userModel?.imageUrl == ''
                          //------------------------------------------------------
                          // Pick image icon when imageUrl was not uploaded to firestore
                          //------------------------------------------------------
                          ? Opacity(
                              opacity: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                                color: ItemColor.itemBlack54,
                                onPressed: () {
                                  // Method to display pick image dialog
                                  imageSourceDialog(
                                    context,
                                    id,
                                    imageUrl,
                                    openCamera,
                                    openGallery,
                                  );
                                },
                              ),
                            )
                          //------------------------------------------------------
                          // User Avatar when imageUrl was uploaded to firestore
                          //------------------------------------------------------
                          : InkWell(
                              onTap: () {
                                // Method to display pick image dialog
                                imageSourceDialog(
                                  context,
                                  id,
                                  imageUrl,
                                  openCamera,
                                  openGallery,
                                );
                              },
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(state.userModel!.imageUrl),
                              ),
                            ),
                    ),
                    //------------------------------------------------------
                    // Email (as a string) of current user
                    //------------------------------------------------------
                    Text(
                      userEmail,
                      style: GoogleFonts.lato(
                        color: ItemColor.itemBlack87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //------------------------------------------------------
              // NAME TextField
              //------------------------------------------------------
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    label: Text(userNameLabel),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              //------------------------------------------------------
              // CITY TextField
              //------------------------------------------------------
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  controller: userCityController,
                  decoration: InputDecoration(
                    label: Text(userCityLabel),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              //------------------------------------------------------
              // GENDER TextField
              //------------------------------------------------------
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  controller: userGenderController,
                  decoration: InputDecoration(
                    label: Text(userGenderLabel),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
