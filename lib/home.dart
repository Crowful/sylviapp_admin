import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sylviapp_admin/map.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool onHov = false;
  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now); // 28/03/2020
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(formatter)],
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
<<<<<<< HEAD
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
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        height: 250,
                                        width: 310,
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xffE7E6E9),
                                                blurRadius: 4,
                                                offset: Offset(
                                                    2, 5), // Shadow position
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
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
                                                  'View Campaign Requests',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xff65BFB8),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Tooltip(
                                                    child: Icon(
                                                      Icons.help_rounded,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      size: 13,
                                                    ),
                                                    message:
                                                        "Newest request: 10:00am October 17, 2021")
                                              ],
=======
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
>>>>>>> fda1796c4f43e2aba0ee86e9606b019b04defd14
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
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, "/verify_users"),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            height: 250,
                                            width: 310,
                                            decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffE7E6E9),
                                                    blurRadius: 4,
                                                    offset: Offset(2,
                                                        5), // Shadow position
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.white),
                                            child: const Center(
                                              child: Text('APPLICATIONS'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          height: 250,
                                          width: 310,
                                          decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xffE7E6E9),
                                                  blurRadius: 4,
                                                  offset: Offset(
                                                      2, 5), // Shadow position
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.white),
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
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xffE7E6E9),
                                                      blurRadius: 4,
                                                      offset: Offset(2,
                                                          5), // Shadow position
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.menu,
                                                            size: 20,
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      '10 campaigns',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
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
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xffE7E6E9),
                                                      blurRadius: 4,
                                                      offset: Offset(2,
                                                          5), // Shadow position
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                      children: const [
                                                        Text(
                                                          '10 basic',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          '10 organizers',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
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
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            height: 250,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/map.png")),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffE7E6E9),
                                                    blurRadius: 4,
                                                    offset: Offset(2,
                                                        5), // Shadow position
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.white),
                                            child: ClipRRect(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      const Color(0xff65BFB8)
                                                          .withOpacity(0.4),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: const ClipRRect(
                                                  child: Center(
                                                    child: Text(
                                                      'Go to Map',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          onHover: (hover) {},
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            height: 250,
                                            width: 350,
                                            decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffE7E6E9),
                                                    blurRadius: 3,
                                                    offset: Offset(2,
                                                        5), // Shadow position
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color(0xff65BFB8)),
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