import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/showFull.dart';
import 'package:transparent_image/transparent_image.dart';
import 'providers/providers.dart';

class VerificationInfo extends StatefulWidget {
  final String userUID;
  final String name;
  final String email;
  VerificationInfo(
      {required this.userUID, required this.name, required this.email});

  @override
  _VerificationInfoState createState() => _VerificationInfoState();
}

class _VerificationInfoState extends State<VerificationInfo> {
  String? link;
  String? link1;
  String? taske;
  String? errorText;
  String urlTest = "";

  Future showFaceURL(uid) async {
    String fileName = "pic";
    String destination = 'files/users/$uid/verification/facePic/$fileName';

    Reference firebaseStorageRef = FirebaseStorage.instance.ref(destination);

    try {
      taske = await firebaseStorageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'invalid-url':
          Fluttertoast.showToast(msg: e.message.toString());
          break;
      }
      setState(() {
        errorText = e.toString();
      });
    }
    setState(() {
      urlTest = taske.toString();
    });
  }

  String? taske2;
  String? errorText2;
  String urlTest2 = "";

  Future showvalidID(uid) async {
    String fileName = "pic";
    String destination = 'files/users/$uid/verification/validID/$fileName';
    Reference firebaseStorageRef = FirebaseStorage.instance.ref(destination);

    try {
      taske2 = await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      setState(() {
        errorText2 = e.toString();
      });
    }
    setState(() {
      urlTest2 = taske2.toString();
    });
  }

  @override
  void initState() {
    showFaceURL(widget.userUID);
    showvalidID(widget.userUID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('verification')
          .doc(widget.userUID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                  width: 400,
                  height: 700,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator())),
            ),
          );
        } else {
          if (snapshot.data!.exists) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Container(
                  width: 500,
                  height: 700,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return ImageFullScreen(
                                imgLink: link!,
                              );
                            }));
                          },
                          child: urlTest != ""
                              ? Container(
                                  height: 200,
                                  width: 300,
                                  child: Image.network(urlTest))
                              : Container(
                                  height: 200,
                                  width: 300,
                                  child: Center(
                                      child: Icon(
                                    Icons.image_rounded,
                                    size: 100,
                                  )))),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name,
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff65BFB8))),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Reason:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff65BFB8)),
                            ),
                            Container(
                                color: Colors.white38,
                                height: 90,
                                width: 300,
                                child: Text(snapshot.data!
                                    .get('reasonForApplication'))),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Valid Id: ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff65BFB8)),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 200,
                                  width: 200,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: urlTest2 != ""
                                      ? Container(
                                          height: 200,
                                          width: 300,
                                          child: Image.network(urlTest2))
                                      : Container(
                                          height: 200,
                                          width: 300,
                                          child: Center(
                                              child: Icon(
                                            Icons.image_rounded,
                                            size: 100,
                                          )))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff65BFB8),
                                      shape: StadiumBorder()),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Back")),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  height: 700,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("THIS USER DIDN'T SUBMIT AN APPLICATION"),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
// Scaffold(
//       body: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('verification')
//               .doc(widget.userUID)
//               .snapshots(),
//           builder: (context, snapshot) {
//             return Center(
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: const EdgeInsets.fromLTRB(350, 100, 350, 0),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 500,
//                         width: 500,
//                         child: Image.network(
//                             "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=466&q=80"),
//                       ),
//                       const SizedBox(height: 50),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(snapshot.data!.get('reasonForApplication')),
//                           const SizedBox(
//                             width: 30,
//                           ),
//                           Text(snapshot.data!.get('reasonForApplication')),
//                         ],
//                       ),
//                       Container(
//                         height: 300,
//                         width: 300,
//                         margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                         child: Image.network(
//                             "https://media.istockphoto.com/photos/covid19-vaccination-record-card-on-white-background-picture-id1297704047"),
//                       ),
//                       const Text("Reason for Applying as an organizer: "),
//                       const Text(
//                           "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsumlorem ipsum lorem ipsum lorem ipsum"),
//                       const Text("Have any Experience?:  No"),
//                       ElevatedButton(
//                           onPressed: () {},
//                           child: const Text("Approve Application"))
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );