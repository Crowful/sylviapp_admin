import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sylviapp_admin/charts.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late String _chosenValue = " ";
  bool onHov = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('quarantineStatus')
        .doc('status')
        .get()
        .then((value) => _chosenValue = value.toString());
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);
    return SafeArea(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.travel_explore,
                      size: 30,
                      color: Color(0xff65BFB8),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.travel_explore,
                              size: 30,
                            ),
                            Icon(
                              Icons.travel_explore,
                              size: 30,
                            ),
                            Icon(
                              Icons.travel_explore,
                              size: 30,
                            ),
                            Icon(
                              Icons.travel_explore,
                              size: 30,
                            ),
                            Icon(
                              Icons.travel_explore,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.red,
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
                            DropdownButton<String>(
                              focusColor: Colors.white,
                              value: null,
                              style: const TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'MECQ',
                                'ECQ',
                                'GCQ',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
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
                            ),
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
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  fontWeight: FontWeight.bold,
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
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.menu))
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
                                                context, '/campaignrequest');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            height: 250,
                                            width: 310,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xff778ba5)
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
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Community Quarantine Status",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          height: 250,
                                          width: 310,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xff778ba5)
                                                      .withOpacity(0.4),
                                                  blurRadius: 4,
                                                  offset: const Offset(
                                                      2, 5), // Shadow position
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
                                              padding: const EdgeInsets.all(20),
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                                                      offset: const Offset(2,
                                                          5), // Shadow position
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          Icons.help_rounded,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
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
                                                        stream:
                                                            FirebaseFirestore
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
                                              padding: const EdgeInsets.all(20),
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                                                      offset: const Offset(2,
                                                          5), // Shadow position
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.menu,
                                                            size: 20,
                                                          ))
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                );
                                                              } else {
                                                                return const SizedBox(
                                                                    height: 10,
                                                                    width: 10,
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                );
                                                              } else {
                                                                return const SizedBox(
                                                                    width: 10,
                                                                    height: 10,
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
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                                                      offset: const Offset(2,
                                                          5), // Shadow position
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white),
                                              child: ClipRRect(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: [
                                                        const Color(0xff65BFB8)
                                                            .withOpacity(0.3),
                                                        Colors.transparent,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: const ClipRRect(
                                                    child: Center(
                                                      child: Text(
                                                        'Go to Map',
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors.white,
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
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            height: 250,
                                            width: 350,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xff778ba5)
                                                            .withOpacity(0.3),
                                                    blurRadius: 4,
                                                    offset: const Offset(2,
                                                        5), // Shadow position
                                                  ),
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                color: const Color(0xff65BFB8)),
                                            child: const Center(
                                              child: Text(
                                                'Manage Users',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
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