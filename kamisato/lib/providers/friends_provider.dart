import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/friend_model.dart';
import '../api/friend_api.dart';

class FriendListProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _friendsStream;
  var firebaseService = FirebaseFriendAPI();

  FriendListProvider() {
    fetchFriends();
  }

  Stream<QuerySnapshot> get friend => _friendsStream;

  // Fetches all friends from the database
  void fetchFriends() {
    _friendsStream = firebaseService.getAllFriends();
    notifyListeners();
  }

  // Adds a friend to the database
  void addFriend(Friend friend) async {
    firebaseService.addFriend(friend.toJson(friend)).then((message) {
      print("Added friend: ${friend.name}");
    });
    notifyListeners();
  }

  // Updates a friend in the database
  void editFriend(Friend friend) {
    if (friend.id != null) {
      firebaseService.editFriend(friend.id!, friend.toJson(friend)).then((message) {
        print("Updated friend: ${friend.name}");
      });
      notifyListeners();
    } else {
      print("Friend ID is null, cannot update.");
    }
  }

  // Deletes a friend from the database
  void deleteFriend(Friend friend) {
    firebaseService.deleteFriend(friend.id!).then((message) {
      print("Deleted friend: ${friend.name}");
    });
    notifyListeners();
  }
}