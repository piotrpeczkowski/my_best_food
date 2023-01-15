import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_best_food/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy('dateTime')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ItemModel(
          id: doc.id,
          dateTime: doc['dateTime'],
          restaurant: doc['restaurant'],
          food: doc['food'],
          price: doc['price'],
          rank: doc['rank'],
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .delete();
  }

  Future<void> add(
    DateTime dateTime,
    String restaurant,
    String food,
    String price,
    String rank,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .add(
      {
        'restaurant': restaurant,
        'food': food,
        'dateTime': dateTime,
        'price': price,
        'rank': rank,
      },
    );
  }
}
