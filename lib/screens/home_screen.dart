import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:attendance_vimigo/models/attendance.dart';

import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/attendance/attendance_list.dart';

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
              Stack(children: <Widget>[
                Positioned(
                  child: ClipRRect(
                     borderRadius: BorderRadius.circular(30),
                    child: Image.asset('assets/images/purple.jpg'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(55),
                  width: MediaQuery.of(context).size.width - 300,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white12,
                  ),
                  child: Text(
                    'Make each day your masterpiece',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Positioned(
                  width: 400,
                  top: 150,
                  left: 0,
                  child: Image.asset('assets/images/3.gif'),
                ),
                Positioned(
                  width: 200,
                  top: 170,
                  right: 0,
                  child: Image.asset('assets/images/4.png'),
                )
              ]),
            ])),
            MultiProvider(
              providers: [
                StreamProvider<List<AttendanceData>>.value(
                    initialData: [],
                    value: AttendanceDatabaseService().attendanceDatalist),
              ],
              child: SingleChildScrollView(
                  child: Container(child: AttendanceList())),
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
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
