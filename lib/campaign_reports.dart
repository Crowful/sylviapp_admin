import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampaignReports extends StatefulWidget {
  const CampaignReports({Key? key}) : super(key: key);

  @override
  _CampaignReportsState createState() => _CampaignReportsState();
}

class _CampaignReportsState extends State<CampaignReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('campaigns').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Container(
                      width: 100,
                      height: 200,
                      margin: EdgeInsets.fromLTRB(500, 0, 500, 10),
                      child: Card(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Row(children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.get('campaign_name'),
                                      style: TextStyle(
                                          color: Color(0xff65BFB8),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Scam Report: ' +
                                          e.get('reportScam').toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Abuse Report: ' +
                                          e.get('reportAbuse').toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Inappropriate Words: ' +
                                          e.get('reportUIW').toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ]),
                              SizedBox(
                                width: 200,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: Text('delete campaign')),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: Text('info of organizer')),
                                  ],
                                ),
                              )
                            ])),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
