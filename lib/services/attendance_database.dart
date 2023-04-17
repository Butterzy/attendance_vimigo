import 'package:attendance_vimigo/models/attendance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceDatabaseService {
  final String? uid;
  final String? aid;
  AttendanceDatabaseService({this.uid, this.aid});

  //registration.......................................................

  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendances');

  Future attendanceEvent(String attendance_time) async {
    return await attendanceCollection.doc().set({
      'user_ID': uid,
      'attendance_time': attendance_time,
    });
  }

  AttendanceData _attendanceDataFromSnapshot(DocumentSnapshot snapshot) {
    return AttendanceData(
      attendance_ID: aid,
      user_ID: snapshot['user_ID'],
      attendance_time: snapshot['attendance_time'],
    );
  }

  List<AttendanceData> _attendanceListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return AttendanceData(
          attendance_ID: doc.id,
          user_ID: doc.get('user_ID'),
          attendance_time: doc.get('attendance_time'),
        );
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Stream<List<AttendanceData>> get attendanceDatalist {
    return attendanceCollection.snapshots().map(_attendanceListFromSnapshot);
  }

  Stream<AttendanceData> get attendancedata {
    return attendanceCollection
        .doc(aid)
        .snapshots()
        .map(_attendanceDataFromSnapshot);
  }
}
