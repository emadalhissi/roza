import 'package:Rehrati/Helpers/snack_bar.dart';
import 'package:Rehrati/Screens/auth/login_screen.dart';
import 'package:Rehrati/Screens/auth/register_with_mobile_screen.dart';
import 'package:Rehrati/Screens/auth/register_with_mobile_screen2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SnackBarHelper {
  late UserCredential userCredential;
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
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Text(
                'REGISTER',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
              onPressed: () async => await performRegister(),
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Have an account? Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterWithMobileScreen2(),
                  ),
                );
              },
              child: Text('Register using mobile'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                UserCredential credential = await signInWithGoogle();
                print('UserCredential:');
                print(credential);
              },
              child: Text('Continue with Google'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // await signInWithFacebook();
              },
              child: Text('Continue with Facebook'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
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

  Future<void> register() async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEditingController.text.toString(),
        password: passwordEditingController.text.toString(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(
          context,
          message: 'The password provided is too weak!',
          error: true,
        );
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          message: 'The account already exists for that email!',
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
