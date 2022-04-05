import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practise/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp())),
              child: Icon(Icons.app_registration_rounded))
        ]),
        body: Column(
          children: [
            Text("Login"),
            TextField(controller: _emailTextEditingController),
            TextField(
              controller: _passwordTextEditingController,
            ),
            IconButton(
                onPressed: () async {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextEditingController.text.trim(),
                          password: _passwordTextEditingController.text);
                },
                icon: Icon(Icons.login)),
            GestureDetector(
                onTap: () async {
                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();

                  // Obtain the auth details from the request
                  final GoogleSignInAuthentication? googleAuth =
                      await googleUser?.authentication;

                  // Create a new credential
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithCredential(credential);
                  print(userCredential.user!.displayName);
                },
                child: Container(
                  child: Text("Google SignIn"),
                ))
          ],
        ),
      ),
    );
  }
}
