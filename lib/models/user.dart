class thisUser {
  final String? uid;

  thisUser({this.uid});
}

class UserData {
  String? user_ID;
  String? user_name;
  String? user_email;
  String? user_HPno;
  String? user_position;
  String? user_department;

  UserData({
    this.user_ID,
    this.user_name,
    this.user_email,
    this.user_HPno,
    this.user_position,
    this.user_department,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'user_email': user_email,
      'user_HPno': user_HPno,
      'user_position': user_position,
      'user_department': user_department,
    };
  }

  factory UserData.fromMap(map) {
    return UserData(
      user_name: map['user_name'],
      user_email: map['user_email'],
      user_HPno: map['user_HPno'],
      user_position: map['user_position'],
      user_department: map['user_department'],
    );
  }
}
