import 'package:flutter/material.dart';
import 'package:sylviapp_admin/map.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 800,
          width: 800,
          child: Column(
            children: [
              Text("ADMIN HOME"),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/map");
                  },
                  child: Text("Create Available forest polygon")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/manage_users");
                  },
                  child: Text("Manage Users")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/analytics");
                  },
                  child: Text("Show Analytics")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/verify_users");
                  },
                  child: Text("Verify Volunteers to be Organizer")),
            ],
          ),
        ),
      ),
    );
  }
}
