import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/domain/aes_cryptography.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:sylviapp_admin/providers/providers.dart';
import 'package:sylviapp_admin/verification_info.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  String? taske;
  String? errorText;
  String urlTest = "";
  String uid = "orc9pQYQ01OLQZ1uDn11VEvAJLn1";
  late String Future;
  showProfile(uid) async {
    String fileName = "pic";
    String destination = 'files/users/$uid/ProfilePicture/$fileName';
    Reference firebaseStorageRef = FirebaseStorage.instance.ref(destination);
    try {
      taske = await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      setState(() {
        errorText = e.toString();
      });
    }
    setState(() {
      urlTest = taske.toString();
    });
  }

  @override
  void initState() {
    showProfile(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        decoration:
                            const BoxDecoration(color: Color(0xffF6F8FA)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(formatter)],
                        ),
                      ),
                      const Text(
                        ' Applicants',
                        style: TextStyle(
                            color: Color(0xff65BFB8),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '  Verify the users',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: ListView(
                            children: snapshot.data!.docs.map((e) {
                              String name = AESCryptography().decryptAES(
                                  enc.Encrypted.fromBase64(e['fullname']));
                              String email = e['email'];
                              bool status = e['isVerify'];

                              return Container(
                                padding: const EdgeInsets.all(20),
                                height: 100,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: status == true
                                        ? Colors.green[50]
                                        : Colors.orange[50],
                                    boxShadow: const [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 1000,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image:
                                                      NetworkImage(urlTest))),
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
                                            status == false
                                                ? const Text(
                                                    "Volunteer",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                : const Text(
                                                    "Organizer",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await context
                                                  .read(authserviceProvider)
                                                  .removerVerification(e.id);
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[400],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5))),
                                              width: 100,
                                              child: const Center(
                                                child: Text(
                                                  'Remove Verification',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await context
                                                  .read(authserviceProvider)
                                                  .verifyAUser(e.id);
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xff65BFB8),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              width: 100,
                                              child: const Center(
                                                child: Text(
                                                  ' Verify',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(
                                                  HeroDialogRoute(
                                                      builder: (context) {
                                                return VerificationInfo(
                                                  userUID: e.id,
                                                  name: name,
                                                  email: email,
                                                );
                                              }));
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              width: 100,
                                              child: const Center(
                                                child: Text(
                                                  ' View Info',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
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
    return SizedBox(
      height: 200,
      width: 800,
      child: Row(
        children: const [
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
