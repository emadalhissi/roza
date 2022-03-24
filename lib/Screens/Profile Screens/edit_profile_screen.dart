import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController mobileEditingController;

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController();
    mobileEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    mobileEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 25,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xff5859F3),
                        ),
                        PositionedDirectional(
                          end: 0,
                          bottom: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(color: const Color(0xffDBDBDB)),
                            ),
                            child: const Center(
                              child: Icon(Icons.photo_camera),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                AppTextField(
                  textEditingController: nameEditingController,
                  hint: 'Full Name',
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: mobileEditingController,
                  hint: 'Mobile',
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    padding: EdgeInsets.zero,
                    primary: const Color(0xff5859F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
