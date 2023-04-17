import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/screens/profile/edit_profile.dart';
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

  get userData => UserData();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<thisUser?>(context);
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            appBar: AppBar(
              title: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text('Profile',
                    //customize textStyle in theme() method
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white)),
              ),
              backgroundColor: Colors.indigo,
              elevation: 0,
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
                      color: Colors.white,
                    ))
              ],
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<UserData>(
                    stream: UserDatabaseService(uid: user!.uid).userData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserData? userData = snapshot.data;
                        var user_role = userData!.user_role ?? "";
                        return ListView(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                //indigoContainer
                                Positioned(
                                  top: 100.0,
                                  left: 10.0,
                                  right: 10.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.indigo,
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
                                            userData.user_email!,
                                            Icons.mail_sharp),
                                        buildProfileInfo(
                                            context,
                                            userData.user_HPno!,
                                            Icons.phone_android_outlined),
                                        buildProfileInfo(
                                            context,
                                            userData.user_gender!,
                                            Icons.phone_android_outlined),
                                      ],
                                    ),
                                  ),
                                ),

                                //avatar
                                Positioned(
                                  top: 0.0,
                                  left: 150.0,
                                  child: buildProfileAvatar(userData),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return ListView(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                //indigoContainer
                                Positioned(
                                  top: 100.0,
                                  left: 10.0,
                                  right: 10.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.indigo,
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
                                            userData.user_email!,
                                            Icons.mail_sharp),
                                        buildProfileInfo(
                                            context,
                                            userData.user_HPno!,
                                            Icons.phone_android_outlined),
                                        buildProfileInfo(
                                            context,
                                            userData.user_gender!,
                                            Icons.phone_android_outlined),
                                      ],
                                    ),
                                  ),
                                ),

                                //avatar
                                Positioned(
                                  top: 0.0,
                                  left: 150.0,
                                  child: buildProfileAvatar(userData),
                                ),
                              ],
                            ),
                          ],
                        );
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
        child: Text('${userData!.user_name!} ${userData.user_lastName!}',
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
        _showEditPanel(userData);
      },
    );
  }

  void _showEditPanel(UserData userData) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        builder: (context) {
          return Wrap(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 20.0),
                    child: Container(
                        height: 5.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.indigo))),
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: const Text(
                      'Edit Profile Action',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0, color: Colors.indigo),
                    ),
                  ),

                  /* InkWell(
                    child: _buildListItem('Edit Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfile(userData: userData),
                          ));
                    },
                  ), */
                ],
              ),
            ],
          );
        });
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
