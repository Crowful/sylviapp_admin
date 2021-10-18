import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sylviapp_admin/analytics.dart';
import 'package:sylviapp_admin/home.dart';
import 'package:sylviapp_admin/login.dart';
import 'package:sylviapp_admin/manage_users.dart';
import 'package:sylviapp_admin/map.dart';
import 'package:sylviapp_admin/verification_info.dart';
import 'package:sylviapp_admin/verify_users.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        "/verification_info": (_) => VerificationInfo(
              userUID: "",
              email: " ",
              name: " ",
            ),
      },
      home: LoginAdmin(),
    );
  }
}
