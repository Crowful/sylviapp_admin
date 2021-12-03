import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/showFull.dart';

class VerificationInfo extends StatefulWidget {
  final String userUID;
  final String name;
  final String email;
  // ignore: prefer_const_constructors_in_immutables
  VerificationInfo(
      {Key? key,
      required this.userUID,
      required this.name,
      required this.email})
      : super(key: key);

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
                    child: const SizedBox(
                        height: 20,
                        width: 20,
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
                                  imgLink: urlTest,
                                );
                              }));
                            },
                            child: urlTest != ""
                                ? SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: Image.network(urlTest))
                                : const SizedBox(
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
                                onTap: () {
                                  Navigator.of(context)
                                      .push(HeroDialogRoute(builder: (context) {
                                    return ImageFullScreen(
                                      imgLink: urlTest2,
                                    );
                                  }));
                                },
                                child: Container(
                                    height: 200,
                                    width: 200,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: urlTest2 != ""
                                        ? SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: Image.network(urlTest2))
                                        : const SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: Center(
                                                child: Icon(
                                              Icons.image_rounded,
                                              size: 100,
                                            )))),
                              ),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xff65BFB8),
                                        shape: const StadiumBorder()),
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
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Center(
                              child: Text(
                                  'This user did not submit credentials')))),
                ),
              );
            }
          }
        });
  }
}
