import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sylviapp_admin/domain/aes_cryptography.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/providers/providers.dart';

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
                      margin: EdgeInsets.fromLTRB(500, 0, 500, 10),
                      child: Row(children: [
                        Container(
                          width: 500,
                          height: 200,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Card(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Row(children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                ])),
                          ),
                        ),
                        Container(
                          width: 210,
                          height: 200,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () async {
                                        await context
                                            .read(authserviceProvider)
                                            .deleteCampaign(e.id)
                                            .whenComplete(() =>
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Campaign Successfully Deleted'));
                                      },
                                      child: Text('delete campaign')),
                                ),
                                Container(
                                  height: 200,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      300, 200, 300, 400),
                                                  child: StreamBuilder<
                                                          DocumentSnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(e.get('uid'))
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Card(
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(),
                                                                ]),
                                                          );
                                                        }
                                                        return Card(
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(AESCryptography().decryptAES(enc
                                                                        .Encrypted
                                                                    .fromBase64(
                                                                        snapshot
                                                                            .data!
                                                                            .get('fullname')))),
                                                                Text(AESCryptography().decryptAES(enc
                                                                        .Encrypted
                                                                    .fromBase64(
                                                                        snapshot
                                                                            .data!
                                                                            .get('address')))),
                                                                Text(AESCryptography().decryptAES(enc
                                                                        .Encrypted
                                                                    .fromBase64(
                                                                        snapshot
                                                                            .data!
                                                                            .get('phoneNumber')))),
                                                              ]),
                                                        );
                                                      }));
                                            });
                                      },
                                      child: Text('info of organizer')),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
