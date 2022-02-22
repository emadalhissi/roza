import 'package:Rehlati/Helpers/snack_bar.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterWithMobileScreen extends StatefulWidget {
  final String phone;

  RegisterWithMobileScreen({this.phone = ''});

  @override
  _RegisterWithMobileScreenState createState() =>
      _RegisterWithMobileScreenState();
}

class _RegisterWithMobileScreenState extends State<RegisterWithMobileScreen>
    with SnackBarHelper {
  late TextEditingController mobileEditingController;
  var otpController = TextEditingController();
  var numController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationId = "";

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print("catch");
    }
  }

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
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Text(
                'Login with mobile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: mobileEditingController,
              decoration: InputDecoration(
                hintText: 'Mobile',
                prefixText: '+972'
              ),
              maxLength: 9,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                await fetchotp();
              },
              child: Text('Send OTP'),
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
  Future<void> fetchotp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: mobileEditingController.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },

      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;

      },

      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }
 // Future<void> sendOTP() async {
 //    await FirebaseAuth.instance.verifyPhoneNumber(
 //        phoneNumber: '+972${mobileEditingController.text.toString()}',
 //        verificationCompleted: (PhoneAuthCredential credential) async {
 //          print('--verificationCompleted--');
 //          await FirebaseAuth.instance
 //              .signInWithCredential(credential)
 //              .then((value) async {
 //            // CupertinoAlertDialog(
 //            //   title: Text("Phone Authentication"),
 //            //   content: Text("Phone Number verified!!!"),
 //            //   actions: [
 //            //     CupertinoButton(
 //            //         child: Text('Close'),
 //            //         onPressed: () {
 //            //           Navigator.of(context).pop();
 //            //         }),
 //            //   ],
 //            // );
 //          });
 //        },
 //        verificationFailed: (FirebaseAuthException e) {
 //          print(e.message);
 //        },
 //        codeSent: (String verficationID, int? resendToken) {
 //          setState(() {
 //            // _verificationCode = verficationID;
 //          });
 //        },
 //        codeAutoRetrievalTimeout: (String verificationID) {
 //          setState(() {
 //            // _verificationCode = verificationID;
 //          });
 //        },
 //        timeout: Duration(seconds: 120));
 //  }
 //
 //  void verifyWithMobile() async {
 //    try {
 //      await FirebaseAuth.instance
 //          .signInWithCredential(PhoneAuthProvider.credential(
 //        verificationId: '',
 //        smsCode: '',
 //      ))
 //          .then((value) async {
 //        CupertinoAlertDialog(
 //          title: Text("Phone Authentication"),
 //          content: Text("Phone Number verified!!!"),
 //          actions: [
 //            CupertinoButton(
 //                child: Text('Close'),
 //                onPressed: () {
 //                  Navigator.of(context).pop();
 //                }),
 //          ],
 //        );
 //      });
 //    } catch (e) {
 //      FocusScope.of(context).unfocus();
 //
 //      showSnackBar(
 //        context,
 //        message: 'Wrong OTP!',
 //        error: true,
 //      );
 //    }
 //  }
}
