import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CodeActiveScreen extends StatefulWidget {
  final String verificationId;
  final String phone;

  const CodeActiveScreen({
    Key? key,
    required this.verificationId,
    required this.phone,
  }) : super(key: key);

  @override
  _CodeActiveScreenState createState() => _CodeActiveScreenState();
}

class _CodeActiveScreenState extends State<CodeActiveScreen> {
  late TextEditingController otpEditingController;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    otpEditingController = TextEditingController();
  }

  @override
  void dispose() {
    otpEditingController.dispose();
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
                'Enter Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: otpEditingController,
              decoration: InputDecoration(
                hintText: 'OTP',
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                await verify();
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

  Future<void> verify() async {
    await auth.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otpEditingController.text.toString(),
        );

        print('Before credential:');
        print(credential);
        await auth.signInWithCredential(credential);

        print('After credential:');
        print(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
