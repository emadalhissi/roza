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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  bool loading = false;

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
        title: Text(
          AppLocalizations.of(context)!.signUp,
          style: const TextStyle(
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
                Text(
                  AppLocalizations.of(context)!.joinOurCommunity,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  textEditingController: nameEditingController,
                  hint: AppLocalizations.of(context)!.fullName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: mobileEditingController,
                  hint: AppLocalizations.of(context)!.mobileNumber,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: emailEditingController,
                  hint: AppLocalizations.of(context)!.email,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: passwordEditingController,
                  hint: AppLocalizations.of(context)!.password,
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
                        title: Text(AppLocalizations.of(context)!.user),
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
                        title: Text(AppLocalizations.of(context)!.office),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await performRegister();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !loading
                        ? Text(
                            AppLocalizations.of(context)!.signUp,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        goToLogin();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: const TextStyle(
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
    if (checkData() == true) {
      await register();
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
        message: AppLocalizations.of(context)!.enterFullName,
        error: true,
      );
      return false;
    } else if (mobileEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterMobile,
        error: true,
      );
      return false;
    } else if (mobileEditingController.text.length != 10) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.mobileMustBe10Digits,
        error: true,
      );
      return false;
    } else if (emailEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterEmailAddress,
        error: true,
      );
      return false;
    } else if (passwordEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterPassword,
        error: true,
      );
      return false;
    } else if (accountType == '') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.chooseAccountType,
        error: true,
      );
      return false;
    }
    return true;
  }

  Future<void> register() async {
    setState(() {
      loading = true;
    });
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEditingController.text.toString(),
        password: passwordEditingController.text.toString(),
      );
      // if (userCredential.user!.emailVerified == false) {
      //   await user!.sendEmailVerification();
      //   showSnackBar(
      //     context,
      //     message: 'Please Check your email for verification link!',
      //     error: false,
      //   );
      // }
      if (accountType == 'user') {
        await createNewUser();
      } else {
        await createNewOffice();
      }
      setState(() {
        loading = false;
      });
      goToLogin();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(
          context,
          message: AppLocalizations.of(context)!.weakPassword,
          error: true,
        );
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          message: AppLocalizations.of(context)!.accountExists,
          error: true,
        );
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.somethingWentWrong,
        error: true,
      );
      setState(() {
        loading = false;
      });
    }
  }

  UserModel get userModel {
    UserModel user = UserModel();
    user.uId = userCredential.user!.uid;
    user.name = nameEditingController.text;
    user.mobile = mobileEditingController.text;
    user.email = emailEditingController.text;
    user.type = accountType;
    user.profileImage = '';
    user.balance = '0';
    user.fcmToken = '';
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
    office.balance = '0';
    office.fcmToken = '';
    return office;
  }

  Future<void> createNewUser() async {
    await FbFireStoreUsersController().createUser(user: userModel);
  }

  Future<void> createNewOffice() async {
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
