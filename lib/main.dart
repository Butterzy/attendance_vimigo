
import 'package:attendance_vimigo/models/user.dart';
import 'package:attendance_vimigo/services/auth.dart';
import 'package:attendance_vimigo/wrapper.dart';
import 'package:flutter/material.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<thisUser?>.value(
      catchError: (context, error) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch:Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        home: wrapper(),
      ),
    );
  }
}
