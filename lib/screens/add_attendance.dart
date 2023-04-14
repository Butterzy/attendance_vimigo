import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/profile/profile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.indigo),
        ),
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
            const SizedBox(height: 10),
            Center(
                child: Column(children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.width * 0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                child: const Text(
                  'Check in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.width * 0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                child: const Text(
                  'Check out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ])),
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
