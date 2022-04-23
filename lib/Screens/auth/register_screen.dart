import 'package:Rehlati/FireBase/fb_firestore_offices_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_users_controller.dart';
import 'package:Rehlati/Helpers/snack_bar.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:Rehlati/models/office.dart';
import 'package:Rehlati/models/user.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  late TextEditingController nameEditingController;
  late TextEditingController mobileEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;

  String accountType = '';

  // String radioGroupValue = 'AccountType';

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController();
    mobileEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    mobileEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Create an Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: mobileEditingController,
                  hint: 'Mobile Number',
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: emailEditingController,
                  hint: 'Email Address',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: passwordEditingController,
                  hint: 'Password',
                  obscure: true,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Radio(
                          value: 'user',
                          groupValue: accountType,
                          activeColor: const Color(0xff5859F3),
                          onChanged: (String? newValue) {
                            setState(() {
                              accountType = newValue!;
                            });
                          },
                        ),
                        title: const Text('User'),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: Radio(
                          value: 'office',
                          groupValue: accountType,
                          activeColor: const Color(0xff5859F3),
                          onChanged: (String? newValue) {
                            setState(() {
                              accountType = newValue!;
                            });
                          },
                        ),
                        title: const Text('Office'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                // const SizedBox(height: 24),
                // const Text(
                //   'Or Sign Up With',
                //   style: TextStyle(
                //     color: Color(0xff8A8A8E),
                //     fontWeight: FontWeight.w600,
                //     fontSize: 16,
                //   ),
                // ),
                // const SizedBox(height: 24),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         SvgPicture.asset(
                //           'assets/icons/google.svg',
                //           height: 35,
                //         ),
                //         const SizedBox(width: 15),
                //         const Text(
                //           'Continue with Google',
                //           style: TextStyle(
                //             color: Color(0xff5859F3),
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.transparent,
                //     minimumSize: const Size(double.infinity, 50),
                //     elevation: 0,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(25),
                //       side: const BorderSide(
                //         color: Color(0xff5859F3),
                //         width: 1.5,
                //       ),
                //     ),
                //   ),
                // ),
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
                        goToLogin();
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
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
      // await SharedPrefController()
      //     .saveFullName(fullName: nameEditingController.text.toString());
    }
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  bool checkData() {
    if (nameEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Full Name!',
        error: true,
      );
      return false;
    } else if (mobileEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Mobile Number!',
        error: true,
      );
      return false;
    } else if (mobileEditingController.text.length != 10) {
      showSnackBar(
        context,
        message: 'Mobile Number Must Be 10 Digits!',
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
    } else if (accountType == '') {
      showSnackBar(
        context,
        message: 'Choose Account Type!',
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
      if (userCredential.user!.emailVerified == false) {
        print('emailVerified == false');
        await user!.sendEmailVerification();
      }
      showSnackBar(
        context,
        message: 'Please Check your email for verification link!',
        error: false,
      );
      if (accountType == 'user') {
        await createNewUser();
      } else {
        await createNewOffice();
      }
      goToLogin();
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
    }
  }

  UserModel get userModel {
    UserModel user = UserModel();
    user.uId = userCredential.user!.uid;
    user.name = nameEditingController.text.toString();
    user.mobile = mobileEditingController.text.toString();
    user.email = emailEditingController.text.toString();
    user.type = accountType;
    user.profileImage = '';
    return user;
  }

  OfficeModel get office {
    OfficeModel office = OfficeModel();
    office.uId = userCredential.user!.uid;
    office.name = nameEditingController.text.toString();
    office.mobile = mobileEditingController.text.toString();
    office.email = emailEditingController.text.toString();
    office.type = accountType;
    office.profileImage = '';
    return office;
  }

  Future<void> createNewUser() async {
    bool status = await FbFireStoreUsersController().createUser(user: userModel);
  }

  Future<void> createNewOffice() async {
    bool status =
        await FbFireStoreOfficesController().createOffice(office: office);
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
