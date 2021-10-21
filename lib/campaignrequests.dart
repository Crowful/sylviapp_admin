import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sylviapp_admin/animations/opaque.dart';

class ShowCampaigneRequests extends StatefulWidget {
  const ShowCampaigneRequests({Key? key}) : super(key: key);

  @override
  _ShowCampaigneRequestsState createState() => _ShowCampaigneRequestsState();
}

class _ShowCampaigneRequestsState extends State<ShowCampaigneRequests> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('admin_campaign_requests')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Text(
                      'Manage Campaign Requests',
                      style: TextStyle(
                          color: Color(0xff65BFB8),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: ListView(
                          children: snapshot.data!.docs.map((e) {
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e['campaign_name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            e['campaign_name'],
                                            style: const TextStyle(
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
                                      // Navigator.of(context).push(
                                      //     HeroDialogRoute(builder: (context) {

                                      // }));
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
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
