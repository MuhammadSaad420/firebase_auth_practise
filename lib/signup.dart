import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practise/home_page.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("Signup"),
            TextField(controller: _emailTextEditingController),
            TextField(
              controller: _passwordTextEditingController,
            ),
            IconButton(
                onPressed: () async {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextEditingController.text.trim(),
                          password: _passwordTextEditingController.text);
                },
                icon: Icon(Icons.login)),
          ],
        ),
      ),
    );
  }
}
