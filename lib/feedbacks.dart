import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as enc;
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylviapp_admin/domain/aes_cryptography.dart';
import 'package:sylviapp_admin/loginwrapper.dart';
import 'package:sylviapp_admin/providers/providers.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
                    const Text(
                      'Feedbacks Of Users',
                      style: TextStyle(
                          color: Color(0xff65BFB8),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.transparent,
                        )),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('feedbacks')
                          .snapshots(),
                      builder: (context, snapshotFeedbacks) {
                        if (!snapshotFeedbacks.hasData) {
                          return const Center(
                              child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator()));
                        } else {
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 400, vertical: 100),
                              child: ListView(
                                  children:
                                      snapshotFeedbacks.data!.docs.map((e) {
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
                                        String name = AESCryptography()
                                            .decryptAES(
                                                enc.Encrypted.fromBase64(
                                                    userSnaps.data!
                                                        .get('fullname')));
                                        String email =
                                            userSnaps.data!.get('email');
                                        return SizedBox(
                                          child: Card(
                                            elevation: 4,
                                            child: Container(
                                              margin: const EdgeInsets.all(20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            name,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            email,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Date Issued: ' +
                                                                string,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Feedback Message:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13),
                                                          ),
                                                          Container(
                                                            height: 200,
                                                            width: 400,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10))),
                                                            child: Text(
                                                              reportMessage,
                                                              style: const TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip),
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
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      Colors
                                                                          .red,
                                                                  shape:
                                                                      const StadiumBorder()),
                                                          onPressed: () async {
                                                            await context
                                                                .read(
                                                                    authserviceProvider)
                                                                .removeFeedback(
                                                                    e.id);
                                                          },
                                                          child: const Text(
                                                              "Delete")),
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
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
