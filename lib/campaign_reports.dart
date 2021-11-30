import 'package:cloud_firestore/cloud_firestore.dart';
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
                      margin: EdgeInsets.fromLTRB(100, 0, 100, 10),
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                              ElevatedButton(
                                  onPressed: null,
                                  child: Text('delete campaign')),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text('info of organizer'))
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
