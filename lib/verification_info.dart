import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/providers.dart';

class VerificationInfo extends StatefulWidget {
  const VerificationInfo({Key? key}) : super(key: key);

  @override
  _VerificationInfoState createState() => _VerificationInfoState();
}

class _VerificationInfoState extends State<VerificationInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.collection('users').doc().snapshots(),
          builder: (context, snapshot) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(350, 100, 350, 0),
                  child: Column(
                    children: [
                      Text(snapshot.data.toString()),
                      Container(
                        height: 500,
                        width: 500,
                        child: Image.network(
                            "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=466&q=80"),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ALFIE C. TRIBACO"),
                          SizedBox(
                            width: 30,
                          ),
                          Text("1203981238"),
                        ],
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Image.network(
                            "https://media.istockphoto.com/photos/covid19-vaccination-record-card-on-white-background-picture-id1297704047"),
                      ),
                      Text("Reason for Applying as an organizer: "),
                      Text(
                          "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum"),
                      Text("Have any Experience?:  No"),
                      ElevatedButton(
                          onPressed: () {}, child: Text("Approve Application"))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
