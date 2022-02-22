import 'package:Rehrati/Screens/auth/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 3), (){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => RegisterScreen()));
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/trip.png', scale: 2.5,),
          Text('Rehlati'),
        ],
      ),
    );
  }
}
