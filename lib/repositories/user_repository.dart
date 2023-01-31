//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_best_food/models/user_model.dart';
//import 'package:image_picker/image_picker.dart';

class UserRepository {
  Future<UserModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userProfile')
        .doc(id)
        .get();
    return UserModel(
      id: doc.id,
      email: userEmail!,
      userName: doc['userName'],
      userCity: doc['userCity'],
      userGender: doc['userGender'],
    );
  }

  Future<void> update(
    String id,
    String userName,
    String userCity,
    String userGender,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userProfile')
        .doc(id)
        .set(
      {
        'userName': userName,
        'userCity': userCity,
        'userGender': userGender,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> updateUserPhoto(
    String id,
    String imageUrl,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userProfile')
        .doc(id)
        .set(
      {
        'imageUrl': imageUrl,
      },
      SetOptions(merge: true),
    );
  }

  // Future pickImage(ImageSource source, File? imageFile) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     final imageTemporary = File(image.path);
  //     imageFile = imageTemporary;
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }
}
