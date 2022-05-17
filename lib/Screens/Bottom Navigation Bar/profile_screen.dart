import 'package:Rehlati/Providers/profile_provider.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/Profile%20Screens/add_trip_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/Profile%20Screens/edit_profile_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/Profile%20Screens/my_trips_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/Profile%20Screens/settings_screen.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/Profile%20Screen%20Widgets/profile_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Provider.of<ProfileProvider>(context).profileImage_ == ''
                  ? const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xff5859F3),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(
                          Provider.of<ProfileProvider>(context).profileImage_),
                    ),
              const SizedBox(height: 10),
              Text(
                Provider.of<ProfileProvider>(context).name_,
                style: const TextStyle(
                  color: Color(0xff5859F3),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              Text(Provider.of<ProfileProvider>(context).email_),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Provider.of<ProfileProvider>(context).accountType_ ==
                            'admin'
                        ? const SizedBox.shrink()
                        : ProfileListTile(
                            title:
                                '${AppLocalizations.of(context)!.balance}: ${Provider.of<ProfileProvider>(context).balance_}',
                            leadingIcon: Icons.attach_money,
                            hasIcon: false,
                          ),
                    Provider.of<ProfileProvider>(context).accountType_ ==
                            'admin'
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ),
                              );
                            },
                            child: ProfileListTile(
                              title: AppLocalizations.of(context)!.editProfile,
                              leadingIcon: Icons.person_outline,
                            ),
                          ),
                    Provider.of<ProfileProvider>(context).accountType_ ==
                            'office'
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddTripScreen(),
                                ),
                              );
                            },
                            child: ProfileListTile(
                              title: AppLocalizations.of(context)!.addTrip,
                              leadingIcon: Icons.add_a_photo_outlined,
                            ),
                          )
                        : const SizedBox.shrink(),
                    Provider.of<ProfileProvider>(context).accountType_ ==
                            'office'
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyTripsScreen(),
                                ),
                              );
                            },
                            child: ProfileListTile(
                              title: AppLocalizations.of(context)!.myTrips,
                              leadingIcon: Icons.map,
                            ),
                          )
                        : const SizedBox.shrink(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      child: ProfileListTile(
                        title: AppLocalizations.of(context)!.settings,
                        leadingIcon: Icons.settings,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 40,
                indent: 16,
                endIndent: 16,
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await SharedPrefController().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Color(0xff5859F3),
                      size: 28,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      AppLocalizations.of(context)!.logout.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xff5859F3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
