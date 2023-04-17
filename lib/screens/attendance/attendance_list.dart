import 'package:attendance_vimigo/models/attendance.dart';
import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/attendance/attendance_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceList extends StatefulWidget {
  AttendanceList({Key? key}) : super(key: key);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  late List<AttendanceData> _attendanceDataList;
  late String searchQuery = '';
  
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final attendanceData = Provider.of<List<AttendanceData>>(context);
    final user = Provider.of<thisUser>(context);

    if (attendanceData.isNotEmpty) {
      List<AttendanceData> myAttendanceData = [];
      for (var i = 0; i < attendanceData.length; i++) {
        //if (attendanceData[i].user_ID == user.uid) {
          myAttendanceData.add(attendanceData[i]);
       // }
      }

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          // Show the end of list indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You have reached the end of the list.'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      });
      debugPrint(user.uid);
      return SingleChildScrollView(
        child: Container(
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: myAttendanceData.length,
            itemBuilder: (context, index) {
              myAttendanceData.sort((a, b) {
                return b.attendance_time!.compareTo(a.attendance_time!);
              });
              return AttendanceTile(
                attendanceData: myAttendanceData[index],
                // userData: user,
              );
            },
          ),
        ),
      );
    } else {
      return Center(
        child: const Text('No check in yet',
            style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
      );
    }
  }
}
