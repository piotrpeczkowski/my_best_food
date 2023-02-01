import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_best_food/features/styles/styles.dart';
import 'package:my_best_food/features/user_page/cubit/user_cubit.dart';
import 'package:my_best_food/models/user_model.dart';
import 'package:my_best_food/repositories/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

// TODO: rebuild uploadFile function for better sync with firebase storage
// TODO: build function for read image by userID from firebase storage

class UserPage extends StatefulWidget {
  UserPage({
    required this.id,
    required this.userEmail,
    Key? key,
  }) : super(key: key);

  final String id;
  final String userEmail;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userCityController = TextEditingController();
  final TextEditingController _userGenderController = TextEditingController();

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  /* 
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        //print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      //print('error occured');
      throw Exception(e);
    }
  }
  */

  String _imageUrl = '';

  Future<void> pickAndUploadImage() async {
    // setup of image picker
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    // when we have picture null, function return nothing
    if (file == null) return;

    // specify the unique name for the files to be stored
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // get reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    // create reference for the picture to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    // try-catch for handling errors
    // way to store our pictures
    try {
      // way to store our picture
      await referenceImageToUpload.putFile(File(file.path));
      _imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      // error
    }
  }

  Future<void> cameraDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Zrób zdjęcie'),
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Zrób zdjęcie')),
        ],
      ),
    );
  }

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
                  imageUrl: _imageUrl,
                  onPressed: () {
                    pickAndUploadImage();
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
                imageUrl: _imageUrl,
                onPressed: () {
                  pickAndUploadImage();
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
    required this.onPressed,
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

  final Function? onPressed;
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
                      padding: const EdgeInsets.only(top: 15, bottom: 25),
                      child: state.userModel?.imageUrl == ''
                          ? Opacity(
                              opacity: 1,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: ItemColor.itemBlack87,
                                child: CircleAvatar(
                                  radius: 49,
                                  backgroundColor:
                                      const Color.fromARGB(255, 200, 200, 200),
                                  child: IconButton(
                                    icon:
                                        const Icon(Icons.add_a_photo, size: 50),
                                    color: ItemColor.itemBlack54,
                                    onPressed: () {
                                      _imageSourceDialog(
                                        context,
                                        id,
                                        imageUrl,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : BlocBuilder<UserCubit, UserState>(
                              builder: (context, state) {
                                final image = state.userModel?.imageUrl;
                                if (image == null) {
                                  return Opacity(
                                    opacity: 1,
                                    child: IconButton(
                                      icon: const Icon(Icons.add_a_photo,
                                          size: 70),
                                      color: ItemColor.itemBlack54,
                                      onPressed: () {
                                        _imageSourceDialog(
                                          context,
                                          id,
                                          imageUrl,
                                        );
                                      },
                                    ),
                                  );
                                }
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(state.userModel!.imageUrl),
                                );
                              },
                            ),
                    ),
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
              // NAME TextField
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
              // CITY TextField
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
              // GENDER TextField
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

  Future<dynamic> _imageSourceDialog(
      BuildContext context, String id, String image) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
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
                  onPressed!();
                  // Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
                  context.read<UserCubit>().updateUserPhoto(
                        id,
                        image,
                      );
                },
                child: Text(
                  'Zapisz i wyjdź',
                  style: GoogleFonts.kanit(
                    fontSize: 16,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
