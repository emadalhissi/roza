import 'package:Rehlati/Providers/lang_provider.dart';
import 'package:Rehlati/main.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/Profile%20Screen%20Widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: ProfileListTile(
                  title: AppLocalizations.of(context)!.language,
                  leadingIcon: Icons.language,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        'No',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, () {
          setState(() {});
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'Yes',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        // await
      },
    );
    Widget mainButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            if (SharedPrefController().getLang == 'ar') {
              Provider.of<LangProvider>(context, listen: false).changeLang();
              RestartWidget.restartApp(context);
            }
          },
          child: const Text(
            'English',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (SharedPrefController().getLang == 'en') {
              Provider.of<LangProvider>(context, listen: false).changeLang();
              RestartWidget.restartApp(context);
            }
          },
          child: const Text(
            'العربية',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.language),
      // content: Text('TEST 2'),
      actions: [
        // cancelButton,
        // continueButton,
        mainButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
