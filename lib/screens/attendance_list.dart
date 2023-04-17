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


  @override
  Widget build(BuildContext context) {
    final attendanceData = Provider.of<List<AttendanceData>>(context);
    final user = Provider.of<thisUser>(context);
    if (attendanceData.isNotEmpty) {
      List<AttendanceData> myAttendanceData = [];
      for (var i = 0; i < attendanceData.length; i++) {
        if (attendanceData[i].user_ID == user.uid) {
          myAttendanceData.add(attendanceData[i]);
        }
      }

      return Column(
        children: [
          ListView.builder(
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemCount: myAttendanceData.length,
  itemBuilder: (context, index) {
    myAttendanceData.sort((a, b) {
          return b.attendance_time!.compareTo(a.attendance_time!);
    });
    return AttendanceTile(
          attendanceData: myAttendanceData[index],
    );
  },
),
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        child: const Text('No Staff Check in yet',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
      );
    }
  }

}
