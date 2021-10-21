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
    return StreamBuilder(
        stream: null,
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
                children: [Text(widget.campaignId)],
              ),
            ),
          );
        });
  }
}
