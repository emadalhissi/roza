import 'package:emadic/Helpers/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithMobileScreen extends StatefulWidget {
  const RegisterWithMobileScreen({Key? key}) : super(key: key);

  @override
  _RegisterWithMobileScreenState createState() =>
      _RegisterWithMobileScreenState();
}

class _RegisterWithMobileScreenState extends State<RegisterWithMobileScreen>
    with SnackBarHelper {
  late UserCredential userCredential;
  User? user = FirebaseAuth.instance.currentUser;
  late TextEditingController mobileEditingController;

  @override
  void initState() {
    super.initState();
    mobileEditingController = TextEditingController();
  }

  @override
  void dispose() {
    mobileEditingController.dispose();

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
              'Enter Mobile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(height: 20),
            TextField(
              controller: mobileEditingController,
              decoration: InputDecoration(hintText: 'Mobile'),
            ),
            SizedBox(height: 20),
            Spacer(),
            ElevatedButton(
              onPressed: () async => await performMobile(),
              child: Text('Continue'),
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

  Future<void> performMobile() async {
    if (checkData()) {
      await mobile();
    }
  }

  bool checkData() {
    if (mobileEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Email!',
        error: true,
      );
      return false;
    }
    return true;
  }

  Future<void> mobile() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: mobileEditingController.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
