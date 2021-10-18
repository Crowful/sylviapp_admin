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
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isVerify', isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                children: const [
                  Text(
                    'Verify the users',
                    style: TextStyle(
                        color: Color(0xff65BFB8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CircularProgressIndicator(),
                ],
              ));
            } else {
              return Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Verify the users',
                      style: TextStyle(
                          color: Color(0xff65BFB8),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 800,
                        child: ListView(
                          children: snapshot.data!.docs.map((e) {
                            String name = AESCryptography().decryptAES(
                                enc.Encrypted.fromBase64(e['fullname']));

                            return Container(
                              padding: const EdgeInsets.all(20),
                              height: 100,
                              margin: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffE7E6E9),
                                      blurRadius: 4,
                                      offset: Offset(2, 5), // Shadow position
                                    ),
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 1000,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=466&q=80"))),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Text(
                                            'Applicant',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationInfo(
                                                      userUID: e.id)));
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff65BFB8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      width: 100,
                                      child: const Center(
                                        child: Text(
                                          'View',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

//  ListTile(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             VerificationInfo(userUID: e.id)));
//                               },
//                               subtitle: const Text("View"),
//                               title: Text(name),
//                             ),
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
