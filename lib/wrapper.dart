import 'package:attendance_vimigo/authenticate/authenticate.dart';
import 'package:attendance_vimigo/mainpage.dart';
import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<thisUser?>(context);

    //return home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen(isCheckedIn: false,);
    }
  }
}
