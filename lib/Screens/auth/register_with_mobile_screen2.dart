import 'package:Rehlati/Helpers/snack_bar.dart';
import 'package:Rehlati/Screens/auth/code_active_screen.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:Rehlati/Screens/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterWithMobileScreen2 extends StatefulWidget {
  RegisterWithMobileScreen2({Key? key});

  @override
  _RegisterWithMobileScreen2State createState() =>
      _RegisterWithMobileScreen2State();
}

class _RegisterWithMobileScreen2State extends State<RegisterWithMobileScreen2>
    with SnackBarHelper {
  late TextEditingController mobileEditingController;
  late TextEditingController otpEditingController;
  String _verificationId = '';
  String countryCode = '+970';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    mobileEditingController = TextEditingController();
    otpEditingController = TextEditingController();
    auth.setLanguageCode('ar');
  }

  @override
  void dispose() {
    mobileEditingController.dispose();
    otpEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          bottom: 25,
          top: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer(),
            Center(
              child: Text(
                'Login with mobile 2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: mobileEditingController,
              decoration: InputDecoration(
                hintText: 'Mobile',
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: Text('+972'),
                // ),
              ),
              // maxLength: 9,/
            ),
            ElevatedButton(
              onPressed: () async {
                // await sendOTP();
                verifyPhoneNumber();
              },
              child: Text('Send OTP'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: otpEditingController,
              decoration: InputDecoration(
                hintText: 'OTP',
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: Text('+972'),
                // ),
              ),
              // maxLength: 9,/
            ),
            ElevatedButton(
              onPressed: () async {
                // await register();
                signInWithPhoneNumber();
              },
              child: Text('Verify'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await auth.signInWithCredential(phoneAuthCredential);
      print(
          'Phone number automatically verified and user signed in: ${auth
              .currentUser!.uid}');
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException
              .code}. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      print('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print('verification code: ' + verificationId);
      _verificationId = verificationId;
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: mobileEditingController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print('Failed to Verify Phone Number: $e');
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpEditingController.text,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;

      print('Successfully signed in UID: ${user!.uid}');
    } catch (e) {
      print('Failed to sign in: ' + e.toString());
    }
  }
}