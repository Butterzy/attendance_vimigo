import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/services/auth.dart';
import 'package:attendance_vimigo/services/user_database.dart';
import 'package:attendance_vimigo/shared/constant.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<thisUser?>(context);
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.amber),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              title: const Text("Profile",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 143, 0, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
              backgroundColor: Colors.white,
              shadowColor: Colors.blue[50],
              elevation: 3,
              actions: [
                IconButton(
                    onPressed: () async {
                      setState(() => isLoading = true);
                      await _auth.signOut().then((value) {
                        showSuccessSnackBar('Signed Out', context);
                      }).catchError((e) {
                        showFailedSnackBar(e.toString(), context);
                      });
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.amber,
                    ))
              ],
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<UserData>(
                    stream: UserDatabaseService(uid: user!.uid).userData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserData? userData = snapshot.data;

                        return ListView(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                //amberContainer
                                Positioned(
                                  top: 100.0,
                                  left: 10.0,
                                  right: 10.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(45),
                                        bottomRight: Radius.circular(45),
                                        topLeft: Radius.circular(45),
                                        bottomLeft: Radius.circular(45),
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        buildNameTitle(context, userData),
                                        buildProfileInfo(
                                            context,
                                            userData!.user_email!,
                                            Icons.mail_sharp),
                                        buildProfileInfo(
                                            context,
                                            userData.user_HPno!,
                                            Icons.phone_android_outlined),
                                        buildProfileInfo(
                                            context,
                                            userData.user_position!,
                                            Icons.person),
                                        buildProfileInfo(
                                            context,
                                            userData.user_department!,
                                            Icons.category),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  width: 300,
                                    top: 0.0,
                                    left: 450.0,
                                    child: Image.asset('assets/images/1.png')),
                                //avatar
                                Positioned(
                                  top: 0.0,
                                  left: 100.0,
                                  child: buildProfileAvatar(userData),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return loadingIndicator();
                      }
                    }),
              ),
            ),
          );
  }

  SizedBox buildProfileInfo(
      BuildContext context, String userData, IconData icon) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
          child: Row(children: [
            Icon(icon, color: Colors.white, size: 25),
            Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(userData,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white)))
          ])),
    );
  }

  Container buildNameTitle(BuildContext context, UserData? userData) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 100),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 25, bottom: 10),
        child: Text('${userData!.user_name!}',
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }

  GestureDetector buildProfileAvatar(UserData? userData) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.amber,
        radius: 60.0,
        child: CircleAvatar(
          backgroundImage:
              AssetImage('assets/images/zhiying.png') as ImageProvider,
          radius: 55.0,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Container _buildListItem(String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
