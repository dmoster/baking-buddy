import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pan_pal/firebase/user.dart';

class Database {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  storeUserData({@required String username}) async {
    DocumentReference documentReferencer = userCollection.doc();

    User user = User(
      username: username,
      presence: true,
      lastSeenInEpoch: DateTime.now().millisecondsSinceEpoch,
    );

    var data = user.toJson();

    await documentReferencer.set(data).whenComplete(() {
      print('User data added');
    }).catchError((error) => print(error));
  }

  Stream<QuerySnapshot> retrieveUsers() {
    Stream<QuerySnapshot> queryUsers =
        userCollection.orderBy('last_seen', descending: true).snapshots();

    return queryUsers;
  }
}
