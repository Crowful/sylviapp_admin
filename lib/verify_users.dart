import 'package:flutter/material.dart';

class VerifyUsers extends StatefulWidget {
  const VerifyUsers({Key? key}) : super(key: key);

  @override
  _VerifyUsersState createState() => _VerifyUsersState();
}

class _VerifyUsersState extends State<VerifyUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: 800,
      width: 800,
      child: Column(
        children: [
          Text("Verify users"),
          SizedBox(height: 30),
          Container(
            height: 500,
            width: 600,
            child: ListView.builder(itemBuilder: (context, index) {
              return Container(
                height: 100,
                width: 600,
                margin: EdgeInsets.only(bottom: 20),
                color: Colors.lightGreenAccent,
                child: Row(
                  children: [
                    SizedBox(
                      width: 49,
                    ),
                    Text("Alfie C. Tribaco"),
                    SizedBox(
                      width: 200,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/verification_info");
                        },
                        child: Text("View")),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Delete")
                  ],
                ),
              );
            }),
          )
        ],
      ),
    )));
  }
}
