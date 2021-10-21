import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/providers/providers.dart';

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
                            String campaignAddress = e['address'];
                            String campaignID = e['campaignID'];
                            String campaignName = e['campaign_name'];
                            String campaignCity = e['city'];
                            double campaignCurrentDonation =
                                e['current_donations'];
                            int campaignCurrentVolunteers =
                                e['current_volunteers'];
                            String campaignDateCreated = e['date_created'];
                            String campaignDateEnded = e['date_ended'];
                            String campaignDateStart = e['date_start'];
                            String campaignDescription = e['description'];
                            double campaignLatitude = e['latitude'];
                            double campaignlongitude = e['longitude'];
                            double campaignMaxDonation = e['max_donation'];
                            int campaignNumberOfSeeds = e['number_of_seeds'];
                            int campaignNumberVolunteers =
                                e['number_volunteers'];
                            String campaignTime = e['time'];
                            String campaignUID = e['uid'];
                            String campaignUsername = e['username'];
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
                                            e['city'],
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
                                      context
                                          .read(authserviceProvider)
                                          .createCampaign(
                                              campaignName,
                                              campaignDescription,
                                              campaignID,
                                              campaignDateCreated,
                                              campaignDateStart,
                                              campaignDateEnded,
                                              campaignAddress,
                                              campaignCity,
                                              campaignTime,
                                              campaignUID,
                                              campaignUsername,
                                              campaignLatitude,
                                              campaignlongitude,
                                              campaignNumberOfSeeds,
                                              campaignCurrentDonation,
                                              campaignMaxDonation,
                                              campaignCurrentVolunteers,
                                              campaignNumberVolunteers);
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
                                          'Approve Campaign',
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
