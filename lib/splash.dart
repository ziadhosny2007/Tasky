import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/login.dart';
import 'package:tasky/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();
      bool? flage = await sharedPreferencesAsync.getBool("isFirst");

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) =>(flage!=false)? Onboarding():Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(child: Image.asset("I/tasky.png")),
    );
  }
}
