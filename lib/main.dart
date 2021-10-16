import 'package:flutter/material.dart';
import 'package:sylviapp_admin/analytics.dart';
import 'package:sylviapp_admin/home.dart';
import 'package:sylviapp_admin/login.dart';
import 'package:sylviapp_admin/manage_users.dart';
import 'package:sylviapp_admin/map.dart';
import 'package:sylviapp_admin/verification_info.dart';
import 'package:sylviapp_admin/verify_users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/admin_home": (_) => const AdminHome(),
        "/login": (_) => const LoginAdmin(),
        "/analytics": (_) => const AdminAnalytics(),
        "/manage_users": (_) => const ManageUsers(),
        "/map": (_) => const MapAdmin(),
        "/verify_users": (_) => const VerifyUsers(),
        "/verification_info": (_) => VerificationInfo(),
      },
      home: LoginAdmin(),
    );
  }
}
