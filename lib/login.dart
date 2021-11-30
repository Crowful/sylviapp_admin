import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylviapp_admin/domain/aes_cryptography.dart';
import 'package:sylviapp_admin/home.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:sylviapp_admin/providers/sharedpreference.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final PrefService _prefService = PrefService();
  late String adminUser = "";
  late String adminPass = "";
  late String storeToken = "";
  late String storeAdminUser = "";
  late String storeAdminPass = "";
  bool isHovering1 = false;
  bool showPass = false;
  int i = 0;
  final double _blur = 5.0;

  final double _size = 20;
  final throttledPerformPunch = throttle(
    () {},
    const Duration(seconds: 15),
  );
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('admin')
        .doc('admin')
        .get()
        .then((value) {
      adminUser = AESCryptography()
          .decryptAES(enc.Encrypted.fromBase64(value["admin_user"]));
      adminPass = AESCryptography()
          .decryptAES(enc.Encrypted.fromBase64(value["admin_pass"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool pending = throttledPerformPunch.isPending;
    return SafeArea(
      child: Scaffold(
        key: widget.key,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width / 2 - 300,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome back, Admin!',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: usernameController,
                              decoration:
                                  const InputDecoration(hintText: "Username"),
                            ),
                            TextField(
                              onSubmitted: (value) {
                                if (usernameController.text.toString() ==
                                        adminUser &&
                                    passwordController.text.toString() ==
                                        adminPass) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminHome()));
                                } else {
                                  i++;

                                  if (i == 5) {
                                    setState(() {
                                      throttledPerformPunch();
                                      i = 0;

                                      Fluttertoast.showToast(
                                          msg: 'You are blocked for 15 seconds',
                                          toastLength: Toast.LENGTH_SHORT);
                                    });
                                  }
                                  usernameController.clear();
                                  passwordController.clear();
                                }
                              },
                              obscureText: showPass ? true : false,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon: showPass
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  hintText: "Password"),
                              onTap: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AbsorbPointer(
                              absorbing: pending ? true : false,
                              child: InkWell(
                                onTap: () async {
                                  if (usernameController.text.toString() ==
                                          adminUser &&
                                      passwordController.text.toString() ==
                                          adminPass) {
                                    storeToken = AESCryptography()
                                        .encryptAES(_randomValue);

                                    _prefService
                                        .createCache(storeToken.toString());

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminHome()));
                                  } else {
                                    i++;

                                    if (i == 5) {
                                      setState(() {
                                        throttledPerformPunch();
                                        i = 0;

                                        Fluttertoast.showToast(
                                            msg:
                                                'You are blocked for 15 seconds',
                                            toastLength: Toast.LENGTH_SHORT);
                                      });
                                    }
                                    usernameController.clear();
                                    passwordController.clear();
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: pending
                                          ? Colors.grey
                                          : const Color(0xff65BFB8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2.5))),
                                  child: const Center(child: Text("Login")),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                onHover: (hovering) {
                  setState(() => isHovering1 = hovering);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 + 300,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/admin.jpg"))),
                  child: ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: isHovering1 ? _blur : 1,
                            sigmaY: isHovering1 ? _blur : 1),
                        child: Container(
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 500),
                            style: TextStyle(fontSize: isHovering1 ? _size : 0),
                            child: isHovering1
                                ? Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'W E L C O M E',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : const Center(child: Text('')),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _randomValue() {
    final rand = Random();
    final codeUnits = List.generate(20, (index) {
      return rand.nextInt(26) + 65;
    });

    return String.fromCharCodes(codeUnits);
  }
}
  //  