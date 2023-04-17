import 'dart:io';

import 'package:attendance_vimigo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDatabaseService {
  final String? uid;
  UserDatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future createUserData(String name, String email, String phone,
      String position, String department) async {
    return await userCollection.doc(uid).set({
      'user_name': name,
      'user_email': email,
      'user_HPno': phone,
      'user_position': position,
      'user_department': department,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      user_ID: uid,
      user_name: snapshot['user_name'],
      user_email: snapshot['user_email'],
      user_HPno: snapshot['user_HPno'],
      user_position: snapshot['user_position'],
      user_department: snapshot['user_department'],
    );
  }

  // userlist from snapshot
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return UserData(
          user_ID: doc.id,
          user_name: doc.get('user_name'),
          user_email: doc.get('user_email'),
          user_HPno: doc.get('user_HPno'),
          user_position: doc.get('user_position'),
          user_department: doc.get('user_department'),
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //get user list stream
  Stream<List<UserData>> get userDataList {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  
}

