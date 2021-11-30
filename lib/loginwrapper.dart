import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sylviapp_admin/home.dart';
import 'package:sylviapp_admin/login.dart';
import 'package:sylviapp_admin/providers/sharedpreference.dart';

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  _LoginWrapperState createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  final PrefService _prefService = PrefService();

  @override
  void initState() {
    super.initState();
    _prefService.readCache("storeToken").then((value) {
      print(value.toString());
      if (value != null) {
        return Timer(
            const Duration(seconds: 2),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdminHome())));
      } else {
        return Timer(
            const Duration(seconds: 2),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginAdmin())));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Icon(
        Icons.app_blocking,
      )),
    );
  }
}
