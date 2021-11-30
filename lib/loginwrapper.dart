import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylviapp_admin/home.dart';
import 'package:sylviapp_admin/login.dart';

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  _LoginWrapperState createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  late String? valuess;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      valuess = value.getString('storeToken');

      print(valuess);
      if (valuess == null) {
        return Timer(
            const Duration(seconds: 2),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginAdmin())));
      } else {
        return Timer(
            const Duration(seconds: 2),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdminHome())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logoblue.png'),
                    fit: BoxFit.contain)),
          ),
          const Text(
            'Sylviapp',
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color(0xff65BFB8)),
          )
        ],
      )),
    );
  }
}
