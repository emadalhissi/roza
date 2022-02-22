import 'package:Rehrati/Helpers/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SnackBarHelper {
  late UserCredential userCredential;
  User? user = FirebaseAuth.instance.currentUser;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;

  @override
  void initState() {
    super.initState();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
                child: Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(height: 20),
            TextField(
              controller: emailEditingController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordEditingController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async => await performLogin(),
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (emailEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Email!',
        error: true,
      );
      return false;
    } else if (passwordEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Password!',
        error: true,
      );
      return false;
    }
    return true;
  }

  Future<void> login() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailEditingController.text.toString(),
        password: passwordEditingController.text.toString(),
      );
      print(userCredential.user!.emailVerified);
      if(userCredential.user!.emailVerified == false) {
        await user!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(
          context,
          message: 'User not found!',
          error: true,
        );
      } else if (e.code == 'wrong-password') {
        showSnackBar(
          context,
          message: 'Wrong password!',
          error: true,
        );
      }
    } catch (e) {
      showSnackBar(
        context,
        message: 'Something went wrong, please try again!',
        error: true,
      );
      print(e);
    }
  }
}
