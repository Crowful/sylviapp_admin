import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as enc;
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/domain/aes_cryptography.dart';
import 'package:sylviapp_admin/loginwrapper.dart';
import 'package:sylviapp_admin/providers/providers.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool pageIsScrolling = false;
  PageController pageController = PageController();
  Timer _timer = Timer(const Duration(milliseconds: 1), () {});
  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(const Duration(minutes: 2), () => _handleInactivity());
  }

  void _handleInactivity() async {
    _timer.cancel();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear().whenComplete(() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginWrapper())));
  }

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _initializeTimer();
      },
      onPanDown: (panDown) {
        _initializeTimer();
      },
      onPanUpdate: (panDown) {
        _initializeTimer();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    InkWell(
                      onTap: () {
                        pageController.jumpTo(1);
                      },
                      child: const Text(
                        'Feedbacks Of Users',
                        style: TextStyle(
                            color: Color(0xff65BFB8),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.transparent,
                        )),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Listener(
                      onPointerMove: (pointerMove) {
                        if (pointerMove is PointerMoveEvent) {
                          _onScroll(pointerMove.delta.dy * -1);
                        }
                      },
                      onPointerSignal: (pointerSignal) {
                        if (pointerSignal is PointerScrollEvent) {
                          _onScroll(pointerSignal.scrollDelta.dy);
                        }
                      },
                      child: PageView(
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: [feedbacksList(), reportList()],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget feedbacksList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedbacks').snapshots(),
        builder: (context, snapshotFeedbacks) {
          if (!snapshotFeedbacks.hasData) {
            return const Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator()));
          } else {
            return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 400, vertical: 100),
                child: ListView(
                    children: snapshotFeedbacks.data!.docs.map((e) {
                  var string = e['date'];
                  var reportMessage = e['feedback'];

                  return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(e['uid'])
                          .snapshots(),
                      builder: (context, userSnaps) {
                        if (!userSnaps.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          String name = AESCryptography().decryptAES(
                              enc.Encrypted.fromBase64(
                                  userSnaps.data!.get('fullname')));
                          String email = userSnaps.data!.get('email');
                          return SizedBox(
                            child: Card(
                              elevation: 4,
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              email,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Date Issued: ' + string,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Feedback Message:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                            Container(
                                              height: 200,
                                              width: 400,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Text(
                                                reportMessage,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.clip),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Center(
                                      child: SizedBox(
                                        height: 50,
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                                shape: const StadiumBorder()),
                                            onPressed: () async {
                                              await context
                                                  .read(authserviceProvider)
                                                  .removeFeedback(e.id);
                                            },
                                            child: const Text("Delete")),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      });
                }).toList()));
          }
        });
  }

  Widget reportList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('campaigns').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView(
              children: snapshot.data!.docs.map((e) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(500, 0, 500, 10),
                  child: Row(children: [
                    Container(
                      width: 500,
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Card(
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Row(children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.get('campaign_name'),
                                      style: const TextStyle(
                                          color: Color(0xff65BFB8),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Scam Report: ' +
                                          e.get('reportScam').toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Abuse Report: ' +
                                          e.get('reportAbuse').toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Inappropriate Words: ' +
                                          e.get('reportUIW').toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ]),
                            ])),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: const StadiumBorder()),
                              onPressed: () async {
                                Navigator.of(context)
                                    .push(HeroDialogRoute(builder: (context) {
                                  return areYouSure(id: e.id);
                                }));
                              },
                              child:
                                  const Center(child: Text("Delete Campaign"))),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  shape: const StadiumBorder()),
                              onPressed: () async {
                                Navigator.of(context)
                                    .push(HeroDialogRoute(builder: (context) {
                                  return showInfo(uid: e.get('uid'));
                                }));
                              },
                              child: const Center(
                                  child: Text('Info of Organizer'))),
                        ),
                      ],
                    )
                  ]),
                );
              }).toList(),
            );
          }
        });
  }

  void _onScroll(double offset) {
    if (pageIsScrolling == false) {
      pageIsScrolling = true;
      if (offset > 0) {
        pageController
            .nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut)
            .then((value) => pageIsScrolling = false);
      } else {
        pageController
            .previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut)
            .then((value) => pageIsScrolling = false);
      }
    }
  }

  Widget areYouSure({required String id}) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 170,
        width: 100,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Are you sure to delete this Campaign?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Deleting this cannot be undone.',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await context
                        .read(authserviceProvider)
                        .deleteCampaign(id.toString())
                        .whenComplete(() {
                      Fluttertoast.showToast(
                          msg: 'Campaign Successfully Deleted');
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xff65BFB8)),
                    height: 45,
                    width: 100,
                    child: const Center(child: Text('Delete')),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue),
                    height: 45,
                    width: 80,
                    child: const Center(child: Text('Cancel')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget showInfo({required String uid}) {
    return Dialog(
      child: Container(
          margin: const EdgeInsets.fromLTRB(300, 200, 300, 400),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                        ]),
                  );
                }
                return Card(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AESCryptography().decryptAES(
                            enc.Encrypted.fromBase64(
                                snapshot.data!.get('fullname')))),
                        Text(AESCryptography().decryptAES(
                            enc.Encrypted.fromBase64(
                                snapshot.data!.get('address')))),
                        Text(AESCryptography().decryptAES(
                            enc.Encrypted.fromBase64(
                                snapshot.data!.get('phoneNumber')))),
                      ]),
                );
              })),
    );
  }
}
