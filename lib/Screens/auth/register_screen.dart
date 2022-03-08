import 'package:Rehlati/Helpers/snack_bar.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:Rehlati/Screens/auth/register_with_mobile_screen.dart';
import 'package:Rehlati/Screens/auth/register_with_mobile_screen2.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SnackBarHelper {
  late UserCredential userCredential;
  late TextEditingController nameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Create an Account',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
          top: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/trip.png',
                scale: 3.3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Join Our Community',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(
                textEditingController: nameEditingController,
                hint: 'Full Name',
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              AppTextField(
                textEditingController: emailEditingController,
                hint: 'Email Address',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                textEditingController: passwordEditingController,
                hint: 'Password',
                obscure: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async => await performRegister(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff5859F3),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Or Sign Up With',
                style: TextStyle(
                  color: Color(0xff8A8A8E),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                        height: 35,
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Color(0xff5859F3),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(
                      color: Color(0xff5859F3),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      // await register();
      await SharedPrefController()
          .saveFullName(fullName: nameEditingController.text.toString());
    }
  }

  bool checkData() {
    if (nameEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Full Name!',
        error: true,
      );
      return false;
    } else if (emailEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Email Address!',
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
