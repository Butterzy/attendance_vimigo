/* import 'package:attendance_vimigo/screens/home_screen.dart';
import 'package:attendance_vimigo/screens/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}




class _MainPageState extends State<MainPage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List pages = [
    HomeScreen(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        key: _bottomNavigationKey,
        height: 50,
        color: Colors.indigo,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.indigo,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn,
      ),
      body: pages[_page],
    );
  }
}
 */