import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sylviapp_admin/domain/aes_cryptography.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:sylviapp_admin/verification_info.dart';

class VerifyUsers extends StatefulWidget {
  const VerifyUsers({Key? key}) : super(key: key);

  @override
  _VerifyUsersState createState() => _VerifyUsersState();
}

class _VerifyUsersState extends State<VerifyUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  width: 800,
                  height: 1000,
                  child: ListView(
                    children: snapshot.data!.docs.map((e) {
                      String name = AESCryptography()
                          .decryptAES(enc.Encrypted.fromBase64(e['fullname']));

                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerificationInfo(userUID: e.id)));
                          },
                          subtitle: Text("View"),
                          title: Text(name),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
          }),
    );
  }

  getAllUsers(AsyncSnapshot<QuerySnapshot> snapshot) {
    return Container(
      height: 200,
      width: 800,
      child: Row(
        children: [
          Text(""),
          SizedBox(
            width: 200,
          ),
          Text("VIEW"),
          SizedBox(
            width: 40,
          ),
          Text("DELETE")
        ],
      ),
    );
  }
}
