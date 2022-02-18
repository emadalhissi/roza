import 'package:emadic/Helpers/snack_bar.dart';
import 'package:emadic/Screens/auth/code_active_screen.dart';
import 'package:emadic/Screens/auth/login_screen.dart';
import 'package:emadic/Screens/auth/register_screen.dart';
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
  String verificationId = '';
  String countryCode = '+970';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    mobileEditingController = TextEditingController();
    otpEditingController = TextEditingController();
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
                //  verifyPhoneNumber();
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
                // signInWithPhoneNumber();
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

  Future<void> sendOTP() async {
    setState(() {
      // loading = true;
    });
    await auth.verifyPhoneNumber(
      phoneNumber: mobileEditingController.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RegisterScreen()),
            ModalRoute.withName('/'),
          );
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verificationFailed error message => ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          this.verificationId = verificationId;
        });

        print("You are logged in, codeSent " + '${verificationId.toString()}');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CodeActiveScreen(
              verificationId: this.verificationId,
              phone: mobileEditingController.text.toString(),
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

// Future<void> resetPassword() async {
//   // bool state = await AutController()
//   //     .verifyOTP(context: context, code: getVerificationCode());
//   // if (state) {
//   //   Navigator.pushNamed(context, "/code_active_screen");
//   // }
//   setState(() {
//     loding = true;
//   });
//   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: widget.virficationid, smsCode: getVerificationCode());
//
//   await auth.signInWithCredential(credential).then(
//     (value) async {
//       setState(() {
//         loding = false;
//       });
//       print("You are logged in successfully then");
//       var user = auth.currentUser!.uid;
//       print("You are logged in successfully then " + user.toString());
//       showSnackBar(
//         context,
//         message: 'You are logged in successfully',
//         error: false,
//       );
//       print(credential.token.toString() + "idtoken phone then");
//       print(credential.signInMethod.toString() + "idtoken phone then");
//       bool state = await AutApiController()
//           .register(context, password: user, username: widget.phone);
//       if (state) {
//         await SharedPrefController().setlogen();
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (BuildContext context) => MainScreens()),
//           ModalRoute.withName('/'),
//         );
//       }
//
//       // Navigator.pushNamed(context, "/home_screen");
//     },
//   ).whenComplete(
//     () async {
//       setState(() {
//         loding = false;
//       });
//       var user = auth.currentUser!.uid;
//       print(credential.providerId.toString() + "idtoken phone whenComplete");
//       bool state = await AutApiController()
//           .register(context, password: user, username: widget.phone);
//       if (state) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) => RegisterScreen()),
//           ModalRoute.withName('/'),
//         );
//       }
//
//       // Navigator.pushNamed(context, "/home_screen");
//     },
//   );
// }
}
