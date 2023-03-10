import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_best_food/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream(
    bool isDescending,
    String orderBy,
  ) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy(orderBy, descending: isDescending)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ItemModel(
          id: doc.id,
          dateTime: (doc['dateTime'] as Timestamp).toDate(),
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
    double rank,
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

  Future<void> update(
    String id,
    String restaurant,
    String food,
    String price,
    double rank,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .update(
      {
        'restaurant': restaurant,
        'food': food,
        'price': price,
        'rank': rank,
      },
    );
  }

  Future<ItemModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .get();
    return ItemModel(
      id: doc.id,
      dateTime: (doc['dateTime'] as Timestamp).toDate(),
      restaurant: doc['restaurant'],
      food: doc['food'],
      price: doc['price'],
      rank: doc['rank'],
    );
  }

  // FOR ARCHIVE COLLECTIONS

  Future<void> addToArchive(
    DateTime dateTime,
    String restaurant,
    String food,
    String price,
    double rank,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('archiveItems')
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
