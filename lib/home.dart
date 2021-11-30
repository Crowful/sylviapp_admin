import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylviapp_admin/campaign_reports.dart';
import 'package:sylviapp_admin/charts.dart';
import 'package:sylviapp_admin/charts/bar_graph.dart';
import 'package:sylviapp_admin/login.dart';
import 'package:sylviapp_admin/loginwrapper.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late String _chosenValue = " ";
  bool onHov = false;
  late String statos = "";
  Timer _timer = Timer(const Duration(milliseconds: 1), () {});
  @override
  void initState() {
    super.initState();
    _initializeTimer();
    FirebaseFirestore.instance
        .collection('quarantineStatus')
        .doc('status')
        .get()
        .then((value) => _chosenValue = value.toString());
  }

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
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);
    return SafeArea(
      child: GestureDetector(
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
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  width: 80,
                  decoration: const BoxDecoration(color: Color(0xffFFFFFF)),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logoblue.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.home,
                                size: 30,
                                color: Color(0xff2b2b2b),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(Icons.analytics,
                                  size: 30, color: Color(0xff65BFB8)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.clear().whenComplete(() =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginWrapper())));
                        },
                        child: const Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          decoration:
                              const BoxDecoration(color: Color(0xffF6F8FA)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.transparent,
                              ),
                              Text(formatter,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('quarantineStatus')
                                      .doc('status')
                                      .snapshots(),
                                  builder: (context, snapshotstatus) {
                                    if (!snapshotstatus.hasData) {
                                      return const Text('Error Please Reload');
                                    } else {
                                      statos =
                                          snapshotstatus.data!.get('status');
                                      return DropdownButton<String>(
                                        focusColor: Colors.white,
                                        value: statos,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        iconEnabledColor: Colors.black,
                                        items: <String>[
                                          'MECQ',
                                          'ECQ',
                                          'GCQ',
                                          'No Quarantine'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          _chosenValue,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _chosenValue = value!;

                                            FirebaseFirestore.instance
                                                .collection('quarantineStatus')
                                                .doc('status')
                                                .set({'status': _chosenValue});
                                          });
                                        },
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 90.0, vertical: 60),
                            decoration:
                                const BoxDecoration(color: Color(0xffF6F8FA)),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: Center(
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'Dashboard',
                                                  style: TextStyle(
                                                      color: Color(0xff65BFB8),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text(
                                                  'Welcome to Sylviapp Dashboard',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            IgnorePointer(
                                              ignoring: true,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.menu,
                                                    color: Colors.transparent,
                                                  )),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/feedback');
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    height: 250,
                                                    width: 315,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                    0xff778ba5)
                                                                .withOpacity(
                                                                    0.4),
                                                            blurRadius: 4,
                                                            offset: const Offset(
                                                                2,
                                                                5), // Shadow position
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: const Color(
                                                            0xffFF673A)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Text(
                                                          "Handle Feedbacks",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            'List of feedbacks by users to be \nconsidered.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                          ),
                                                        )
                                                      ],
                                                    ))),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              height: 250,
                                              width: 312,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xff778ba5)
                                                          .withOpacity(0.4),
                                                      blurRadius: 4,
                                                      offset: const Offset(2,
                                                          5), // Shadow position
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white),
                                              child: const Center(
                                                  child: FittedBox(
                                                child: Chart(),
                                              )),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  width: 350,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0xff778ba5)
                                                              .withOpacity(0.4),
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                              2,
                                                              5), // Shadow position
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.white),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Total Campaigns',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff65BFB8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Tooltip(
                                                            message:
                                                                "Total Active Campaigns done by Sylviapp",
                                                            child: Icon(
                                                              Icons
                                                                  .help_rounded,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.7),
                                                              size: 13,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Center(
                                                        child: StreamBuilder<
                                                                QuerySnapshot>(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'campaigns')
                                                                .snapshots(),
                                                            builder: (context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snaphots) {
                                                              if (!snaphots
                                                                  .hasData) {
                                                                return const SizedBox(
                                                                  height: 10,
                                                                  width: 10,
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child: Text(
                                                                    snaphots
                                                                            .data!
                                                                            .docs
                                                                            .length
                                                                            .toString() +
                                                                        " Campaign(s)",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                );
                                                              }
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  height: 120,
                                                  width: 350,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0xff778ba5)
                                                              .withOpacity(0.4),
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                              2,
                                                              5), // Shadow position
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.white),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Total Users',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff65BFB8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Tooltip(
                                                            message:
                                                                "Total Users in the system Sylviapp",
                                                            child: Icon(
                                                              Icons
                                                                  .help_rounded,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.7),
                                                              size: 13,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .where(
                                                                        'isVerify',
                                                                        isNotEqualTo:
                                                                            true)
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    notTrue) {
                                                                  if (notTrue
                                                                      .hasData) {
                                                                    return Text(
                                                                      notTrue
                                                                              .data!
                                                                              .docs
                                                                              .length
                                                                              .toString() +
                                                                          ' Volunteer(s)',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    );
                                                                  } else {
                                                                    return const SizedBox(
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            10,
                                                                        child:
                                                                            CircularProgressIndicator());
                                                                  }
                                                                }),
                                                            StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .where(
                                                                        'isVerify',
                                                                        isEqualTo:
                                                                            true)
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    return Text(
                                                                      snapshot
                                                                              .data!
                                                                              .docs
                                                                              .length
                                                                              .toString() +
                                                                          ' Organizer(s)',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    );
                                                                  } else {
                                                                    return const SizedBox(
                                                                        width:
                                                                            10,
                                                                        height:
                                                                            10,
                                                                        child:
                                                                            CircularProgressIndicator());
                                                                  }
                                                                }),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, "/map_polygon");
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  height: 250,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      image: const DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              "assets/images/map.png")),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0xff778ba5)
                                                              .withOpacity(0.4),
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                              2,
                                                              5), // Shadow position
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.white),
                                                  child: ClipRRect(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                          colors: [
                                                            const Color(
                                                                    0xff65BFB8)
                                                                .withOpacity(
                                                                    0.3),
                                                            Colors.transparent,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: const ClipRRect(
                                                        child: Center(
                                                          child: Text(
                                                            'Go to Map',
                                                            style: TextStyle(
                                                                fontSize: 30,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => Navigator.pushNamed(
                                                  context, "/manage_users"),
                                              onHover: (hover) {},
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                height: 250,
                                                width: 350,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                                0xff778ba5)
                                                            .withOpacity(0.3),
                                                        blurRadius: 4,
                                                        offset: const Offset(2,
                                                            5), // Shadow position
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: const Color(
                                                        0xff65BFB8)),
                                                child: const Center(
                                                  child: Text(
                                                    'Manage Users',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CampaignReports())),
                                              onHover: (hover) {},
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                height: 250,
                                                width: 350,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                                0xff778ba5)
                                                            .withOpacity(0.3),
                                                        blurRadius: 4,
                                                        offset: const Offset(2,
                                                            5), // Shadow position
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: const Color(
                                                        0xffffBFB8)),
                                                child: const Center(
                                                  child: Text(
                                                    'Manage Reports',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 500,
                                        ),
                                        Container(
                                            child: Text('Analytics',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        SizedBox(
                                          height: 100,
                                        ),
                                        Container(child: BarGraph()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
}

//  const Text("ADMIN HOME"),
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, "/map");
//                   },
//                   child: const Text("Create Available forest polygon")),
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, "/manage_users");
//                   },
//                   child: const Text("Manage Users")),
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, "/analytics");
//                   },
//                   child: const Text("Show Analytics")),
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, "/verify_users");
//                   },
//                   child: const Text("Verify Volunteers to be Organizer")),