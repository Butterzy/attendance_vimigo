import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:attendance_vimigo/models/attendance.dart';

import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/attendance_list.dart';

import 'package:attendance_vimigo/screens/profile/profile.dart';
import 'package:attendance_vimigo/services/attendance_database.dart';

import 'package:attendance_vimigo/shared/constant.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final bool isCheckedIn;
  HomeScreen({Key? key, required this.isCheckedIn}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<thisUser?>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vimigo",
            overflow: TextOverflow.clip,
            style: const TextStyle(
                color: Color.fromRGBO(255, 143, 0, 1),
                fontWeight: FontWeight.bold,
                fontSize: 18.0)),
        backgroundColor: Colors.white,
        shadowColor: Colors.blue[50],
        elevation: 3,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
              },
              icon: Container(
                child: ClipOval(
                    child: Align(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: Image.asset('assets/images/zhiying.png'),
                )),
              ))
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
                child: Column(children: <Widget>[
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/purple.jpg'),
              ),
            ])),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            MultiProvider(
              providers: [
                StreamProvider<List<AttendanceData>>.value(
                    initialData: [],
                    value: AttendanceDatabaseService().attendanceDatalist),
              ],
              child: SingleChildScrollView(
                child: Container(child: AttendanceList())
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String attendance_time = DateTime.now().toString();
                dynamic result = await AttendanceDatabaseService(uid: user!.uid)
                    .attendanceEvent(attendance_time)
                    .whenComplete(() {
                  showSuccessSnackBar('Check in Done !', context);
                }).catchError((e) => showFailedSnackBar(e.toString(), context));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildProfileAvatar(UserData? userData) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.indigo,
        radius: 60.0,
        child: CircleAvatar(
          backgroundImage: userData!.user_photo!.isNotEmpty
              ? NetworkImage('${userData.user_photo}')
              : const AssetImage('assets/images/logo.png') as ImageProvider,
          radius: 55.0,
          backgroundColor: Colors.white,
          child: Stack(
            children: const [
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 17.0,
                  child: Icon(Icons.edit),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Profile();
      },
    );
  }
}
