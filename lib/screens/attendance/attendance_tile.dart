import 'package:attendance_vimigo/models/attendance.dart';
import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class AttendanceTile extends StatefulWidget {
  late AttendanceData attendanceData;
  bool _isDateFormatted = false;

  

  AttendanceTile(
      {Key? key, required this.attendanceData})
      : super(key: key);

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  bool _isDateFormatted = false;
  
  late AttendanceData attendanceData;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<thisUser?>(context);
    debugPrint('this is ' + user!.uid.toString());
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        child: InkWell(
          child: Card(
            elevation: 2.0,
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
            child: ListTile(
              title: Text(widget.attendanceData!.user_ID.toString()),
              subtitle: Text(
                  'Check in ${_isDateFormatted ? DateFormat('dd MMM yyyy, h:mm a').format(DateTime.parse(widget.attendanceData!.attendance_time!)) : timeago.format(DateTime.parse(widget.attendanceData!.attendance_time!))}'),
              trailing: IconButton(
                icon: Icon(_isDateFormatted
                    ? Icons.calendar_today
                    : Icons.access_time),
                onPressed: () {
                  setState(() {
                    _isDateFormatted = !_isDateFormatted;
                  });
                },
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoScreen(),
                    ));
          },
        ),
      ),
    );
  }


}
