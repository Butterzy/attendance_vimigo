

import 'package:attendance_vimigo/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';


class SignIn extends StatefulWidget {
  final toggleView;

  const SignIn({Key? key, this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool isLoading = false;
  bool isObsure = true;

  //text field state
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return isLoading
        ? loadingIndicator()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Container(
                    width: deviceSize.width * 0.55,
                    height: deviceSize.height,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
  

                          const SizedBox(height: 20.0),
                          SizedBox(child: buildEmailForm(emailController, 'Email'),width: 500,),
                          const SizedBox(height: 20.0),
                          SizedBox(child: buildPasswordForm(passwordController, 'Password'),width: 500,),
                          const SizedBox(height: 20.0),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14.0),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => isLoading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Could not sign in with those credentials';
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                
                                backgroundColor: Colors.indigo,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            width: 200,
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Don't have an account ? "),
                              GestureDetector(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.indigo),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  TextFormField buildEmailForm(
      TextEditingController controller, String hintText) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      textInputAction: TextInputAction.next,
      validator: emailValidator,
      onSaved: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(labelText: 'Email' ,prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.email,
          ),
          
        )),
    );
  }

  TextFormField buildPasswordForm(
      TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      obscureText: isObsure,
      textInputAction: TextInputAction.done,
      validator: passwordValidator,
      onSaved: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(labelText: 'Password' ,prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            Icons.vpn_key_sharp,
          ),
          
        ),suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObsure = !isObsure;
                  if (textFieldFocusNode.hasPrimaryFocus) return;
                  textFieldFocusNode.canRequestFocus = false;
                });
              },
              child: Icon(isObsure ? Icons.visibility : Icons.visibility_off))),
      
      
    
    );
  }
}


