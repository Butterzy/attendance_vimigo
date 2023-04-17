import 'package:attendance_vimigo/models/attendance.dart';
import 'package:attendance_vimigo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class AttendanceTile extends StatefulWidget {
  AttendanceData? attendanceData;
  bool _isDateFormatted = false;
  AttendanceTile({Key? key, required this.attendanceData}) : super(key: key);

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  UserData? userData;

  bool _isDateFormatted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        child: InkWell(
          child: Card(
            elevation: 2.0,
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
            child: ListTile(
              title: Text('${userData?.user_ID}'),
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
            _showInfoPanel(userData!, context);
          },
        ),
      ),
    );
  }

  void _showInfoPanel(UserData userData, BuildContext context) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 20.0),
                        child: Container(
                            height: 5.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)))),
                      ),
                      //--------------------------------USER INFO------------------------------------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'hi',
                            // userData.user_lastName!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.indigo),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //---------------------------END OF NARVAR----------------------
              ),
            ),
          );
        });
  }
}
