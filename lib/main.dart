import 'package:Rehlati/Providers/lang_provider.dart';
import 'package:Rehlati/database/db_controller.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Rehlati/Screens/launch_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharedPref();
  await DbController().initDatabase();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LangProvider>(
            create: (context) => LangProvider(),
          )
        ],
        child: const MyMaterialApp(),
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LaunchScreen(),
      theme: ThemeData(
          fontFamily:
              SharedPrefController().getLang == 'en' ? 'Quicksand' : 'Tajawal'),
      // localizationsDelegates: const [
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      locale: Locale(SharedPrefController().getLang),
    );
  }
}
// FOR RESTARTING APP
// CALL IT FROM ANYWHERE USING => RestartWidget.restartApp(context)

class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
