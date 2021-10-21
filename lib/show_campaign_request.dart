import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowCampaign extends StatefulWidget {
  final String campaignId;
  const ShowCampaign({Key? key, required this.campaignId}) : super(key: key);

  @override
  ShowCampaignState createState() => ShowCampaignState();
}

class ShowCampaignState extends State<ShowCampaign> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('admin_campaign_requests')
            .doc(widget.campaignId)
            .snapshots(),
        builder: (context, snapshot) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 200,
              width: 1000,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Text(widget.campaignId),
                  Text(snapshot.data!.get('campaign_name')),
                  Text(snapshot.data!.get('address')),
                  Text(snapshot.data!.get('campaignID')),
                  Text(snapshot.data!.get('city')),
                  Text(snapshot.data!.get('current_donations').toString()),
                  Text(snapshot.data!.get('current_volunteers').toString()),
                  Text(snapshot.data!.get('date_created')),
                  Text(snapshot.data!.get('date_ended')),
                  Text(snapshot.data!.get('date_start')),
                  Text(snapshot.data!.get('description')),
                  Text(snapshot.data!.get('latitude').toString()),
                  Text(snapshot.data!.get('longitude').toString()),
                  Text(snapshot.data!.get('max_donation').toString()),
                  Text(snapshot.data!.get('number_of_seeds').toString()),
                  Text(snapshot.data!.get('number_volunteers').toString()),
                  Text(snapshot.data!.get('radius').toString()),
                  Text(snapshot.data!.get('time')),
                  Text(snapshot.data!.get('uid')),
                ],
              ),
            ),
          );
        });
  }
}
