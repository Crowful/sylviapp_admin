import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/showFull.dart';
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
  String? taske;
  String? errorText;
  String urlTest = "";

  Future showProfile(uid) async {
    String fileName = "pic";
    String destination = 'files/users/$uid/ProfilePicture/$fileName';
    ;
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
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('verification')
          .doc(widget.userUID)
          .snapshots(),
      builder: (context, snapshot) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          backgroundColor: Colors.transparent,
<<<<<<< Updated upstream
          child: Container(
            width: 400,
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
                        imgLink:
                            "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=466&q=80",
                      );
                    }));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
=======
          child: SingleChildScrollView(
            child: Container(
              width: 400,
              height: 700,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
>>>>>>> Stashed changes
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
<<<<<<< Updated upstream
                              "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=466&q=80",
                            ))),
                    height: 230,
                    width: double.infinity,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          snapshot.data!.get(
                            'fullname',
                          ),
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
                      Text(snapshot.data!.get('reasonForApplication')),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Valid Id:',
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
                                imgLink:
                                    "https://media.istockphoto.com/photos/covid19-vaccination-record-card-on-white-background-picture-id1297704047");
                          }));
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Image.network(
                              "https://media.istockphoto.com/photos/covid19-vaccination-record-card-on-white-background-picture-id1297704047"),
                        ),
                      ),
                    ],
=======
                              urlTest,
                            ))),
                    height: 230,
                    width: double.infinity,
>>>>>>> Stashed changes
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            snapshot.data!.get(
                              'fullname',
                            ),
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
                        Text(snapshot.data!.get('reasonForApplication')),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Valid Id:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff65BFB8)),
                        ),
                        Container(
                          height: 200,
                          width: 200,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Image.network(
                              "https://media.istockphoto.com/photos/covid19-vaccination-record-card-on-white-background-picture-id1297704047"),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Verify this user"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
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