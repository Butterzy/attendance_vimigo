class thisAttendanceUser {
  final String? uid;

  thisAttendanceUser({this.uid});
}

class AttendanceData {
  String? user_ID;
  String? attendance_ID;
  String? attendance_time;
  String? name;

  AttendanceData({
    this.user_ID,
    this.attendance_ID,
    this.attendance_time,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'attendance_ID': attendance_ID,
      'attendance_time': attendance_time,
      'name' : name,
    };
  }

  factory AttendanceData.fromMap(map) {
    return AttendanceData(
        attendance_ID: map['attendance_ID'],
        attendance_time: map['attendance_time'],
        name: map['name']);
  }
}
