import 'package:Rehlati/Providers/profile_provider.dart';
import 'package:Rehlati/Screens/auth/register_screen.dart';
import 'package:Rehlati/Screens/home_screen.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SnackBarHelper {
  late UserCredential userCredential;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  CollectionReference officesCollectionReference =
      FirebaseFirestore.instance.collection('offices');
  CollectionReference adminCollectionReference =
      FirebaseFirestore.instance.collection('admins');

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
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.login,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/trip.png',
                  scale: 3.3,
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please enter your email and password',
                  style: TextStyle(
                    color: Color(0xff8A8A8E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xff22292E),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async => await performLogin(),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Login',
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
                //   'Or',
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
                      'Don’t have an account? ',
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
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
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

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (emailEditingController.text.isEmpty) {
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

  Future<void> login() async {
    await adminCollectionReference
        .doc(emailEditingController.text)
        .get()
        .then((value) async {
      if (value.exists) {
        if (emailEditingController.text == value.get('email') &&
            passwordEditingController.text == value.get('password')) {
          await SharedPrefController().login();
          Provider.of<ProfileProvider>(context, listen: false)
              .setUserId_(value.get('email'));
          Provider.of<ProfileProvider>(context, listen: false)
              .setEmail_(value.get('email'));
          Provider.of<ProfileProvider>(context, listen: false)
              .setAccountType_('admin');
          Provider.of<ProfileProvider>(context, listen: false)
              .setName_(value.get('name'));
          showSnackBar(
            context,
            message: 'Admin Logged In!',
            error: false,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          showSnackBar(
            context,
            message: 'Wrong admin password!',
            error: true,
          );
        }
      } else {
        try {
          userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailEditingController.text.toString(),
            password: passwordEditingController.text.toString(),
          );
          await SharedPrefController().login();
          Provider.of<ProfileProvider>(context, listen: false)
              .setUserId_(userCredential.user!.uid);
          Provider.of<ProfileProvider>(context, listen: false)
              .setEmail_(userCredential.user!.email!);
          await usersCollectionReference
              .doc(userCredential.user!.uid)
              .get()
              .then((userDoc) {
            if (userDoc.exists) {
              Provider.of<ProfileProvider>(context, listen: false)
                  .setAccountType_('user');
              Provider.of<ProfileProvider>(context, listen: false)
                  .setName_(userDoc.get('name'));
              Provider.of<ProfileProvider>(context, listen: false)
                  .setMobile_(userDoc.get('mobile'));
              Provider.of<ProfileProvider>(context, listen: false)
                  .setProfileImage_(userDoc.get('profileImage'));
            }
          });
          await officesCollectionReference
              .doc(userCredential.user!.uid)
              .get()
              .then((officeDoc) {
            if (officeDoc.exists) {
              Provider.of<ProfileProvider>(context, listen: false)
                  .setAccountType_('office');
              Provider.of<ProfileProvider>(context, listen: false)
                  .setName_(officeDoc.get('name'));
              Provider.of<ProfileProvider>(context, listen: false)
                  .setMobile_(officeDoc.get('mobile'));
              Provider.of<ProfileProvider>(context, listen: false)
                  .setProfileImage_(officeDoc.get('profileImage'));
            }
          });
          showSnackBar(
            context,
            message: 'You are Logged In!',
            error: false,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
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
        }
      }
    }).catchError((onError) {});
  }
}
