import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Container loadingIndicator() {
  return Container(
    color: Colors.white,
    child: const Center(
      child: SpinKitHourGlass(
        color: Colors.amber,
        size: 50.0,
      ),
    ),
  );
}

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title,
        style: const TextStyle(
            color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 20.0)),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back, color: Colors.indigo),
    ),
  );
}

showNormalSnackBar(String snacktext, BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.info_outline, color: Colors.white, size: 20.0),
        const SizedBox(width: 10.0),
        Flexible(
            child: Text(snacktext,
                style: const TextStyle(fontSize: 18.0, color: Colors.white)))
      ],
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.indigo,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showSuccessSnackBar(String snacktext, BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.info_outline, color: Colors.white, size: 20.0),
        const SizedBox(width: 10.0),
        Flexible(
            child: Text(snacktext,
                style: const TextStyle(fontSize: 18.0, color: Colors.white)))
      ],
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showFailedSnackBar(String snacktext, BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.info_outline, color: Colors.white, size: 20.0),
        const SizedBox(width: 10.0),
        Flexible(
            child: Text(snacktext,
                style: const TextStyle(fontSize: 18.0, color: Colors.white)))
      ],
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

var textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
);

String? emailValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter the email';
  }
  //reg expression for email validation
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
    return 'Please Enter a valid email';
  }
  return null;
}

String? passwordValidator(value) {
  RegExp regex = RegExp(r'^.{6,}$');
  if (value!.isEmpty) {
    return 'Password is required';
  }
  if (!regex.hasMatch(value)) {
    return 'Please enter valid password (Min. 6 character)';
  }
  return null;
}

String? nameValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your name';
  }
  if (value!.length < 2) {
    return 'Your name is required at least 2 characters';
  }
  return null;
}

String? phoneNoValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your phone number';
  }
  if (value!.length == 11 || value!.length == 12) {
    return null;
  } else {
    return 'Please enter a valid phone number !';
  }
}

String? departmentValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your department';
  }
}

String? positionValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your position';
  }
}
