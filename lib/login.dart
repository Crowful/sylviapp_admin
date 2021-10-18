import 'dart:ui';

import 'package:flutter/material.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  bool isHovering1 = false;
  final double _blur = 5.0;
  final double _size = 20;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    hintText: "Password")),
                            ElevatedButton(
                                onPressed: () {
                                  if (usernameController.text == "admin" &&
                                      passwordController.text == "123456") {
                                    Navigator.pushNamed(context, "/admin_home");
                                  } else {
                                    // ignore: avoid_print
                                    print("auth failed");
                                  }
                                },
                                child: const Text("Login"))
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
                                        Text('wew'),
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
}
  //  