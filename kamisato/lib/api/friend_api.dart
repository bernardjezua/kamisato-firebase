import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFriendAPI {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllFriends() {
    return db.collection('friends').snapshots();
  }

  Future<void> addFriend(Map<String, dynamic> friend) async {
    try {
      await db.collection("friends").add(friend);
    } on FirebaseException catch (e) {
      print("Failed with error: ${e.code}");
    }
  }

  Future<void> editFriend(String id, Map<String, dynamic> friendData) async {
    try {
      await db.collection("friends").doc(id).update(friendData);
    } on FirebaseException catch (e) {
      print("Failed with error: ${e.code}");
    }
  }

  Future<void> deleteFriend(String id) async {
    try {
      await db.collection("friends").doc(id).delete();
    } on FirebaseException catch (e) {
      print("Failed with error: ${e.code}");
    }
  }
}