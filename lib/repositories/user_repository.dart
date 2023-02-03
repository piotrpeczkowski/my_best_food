import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_best_food/models/user_model.dart';

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
      imageUrl: doc['imageUrl'],
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

  Future<void> pickAndUploadImage(
    String id,
    String imageUrl,
    ImageSource source,
  ) async {
    final dateTimeFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final firebaseStorageReference = FirebaseStorage.instance.ref();
    final userID = FirebaseAuth.instance.currentUser?.uid;

    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file == null) return;

    String uniqueFileName = dateTimeFileName;
    Reference referenceRoot = firebaseStorageReference;
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      //print(imageUrl);
    } catch (error) {
      throw Exception(error);
    }

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
}
