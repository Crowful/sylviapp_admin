import 'package:flutter/material.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: "Username"),
              ),
              TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: "Password")),
              ElevatedButton(
                  onPressed: () {
                    if (usernameController.text == "admin" &&
                        passwordController.text == "123456") {
                      Navigator.pushNamed(context, "/admin_home");
                    } else {
                      print("auth failed");
                    }
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
