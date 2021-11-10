import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/providers/providers.dart';

class ShowCampaign extends StatefulWidget {
  final String campaignId;
  final String? organizerId;
  const ShowCampaign({Key? key, required this.campaignId, this.organizerId})
      : super(key: key);

  @override
  ShowCampaignState createState() => ShowCampaignState();
}

class ShowCampaignState extends State<ShowCampaign> {
  String? taske;
  String? errorText;
  String urlTest = "";
  showProfile(uid) async {
    String fileName = "pic";
    String destination = 'files/users/$uid/ProfilePicture/$fileName';
    Reference firebaseStorageRef = FirebaseStorage.instance.ref(destination);
    try {
      taske = await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      setState(() {
        errorText = e.toString();
      });
    }
    setState(() {
      urlTest = taske.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProfile(widget.organizerId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('admin_campaign_requests')
            .doc(widget.campaignId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                height: MediaQuery.of(context).size.height - 225,
                width: 1000,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        width: 1000,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/placeholder.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff65BFB8)
                                            .withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "About the organizer",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color(0xff65BFB8)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data!.get('description'),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black
                                                  .withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 250,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff65BFB8)
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: StreamBuilder<Object>(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Status",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color(0xff65BFB8)),
                                            ),
                                            Text(
                                              'male 19',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black
                                                      .withOpacity(0.8)),
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff65BFB8)
                                            .withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Campaign Descirption",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color(0xff65BFB8)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data!.get('description'),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black
                                                  .withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 450,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff65BFB8)
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Information",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color(0xff65BFB8)),
                                      ),
                                      Text(
                                        'male 19',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                context
                                    .read(authserviceProvider)
                                    .createCampaign(
                                        snapshot.data!.get('campaign_name'),
                                        snapshot.data!.get('description'),
                                        snapshot.data!.get('campaignID'),
                                        snapshot.data!.get('date_created'),
                                        snapshot.data!.get('date_start'),
                                        snapshot.data!.get('date_ended'),
                                        snapshot.data!.get('address'),
                                        snapshot.data!.get('city'),
                                        snapshot.data!.get('time'),
                                        snapshot.data!.get('uid'),
                                        snapshot.data!.get('username'),
                                        snapshot.data!.get('latitude'),
                                        snapshot.data!.get('longitude'),
                                        snapshot.data!.get('number_of_seeds'),
                                        snapshot.data!.get('current_donations'),
                                        snapshot.data!.get('max_donation'),
                                        snapshot.data!
                                            .get('current_volunteers'),
                                        snapshot.data!.get('number_volunteers'))
                                    .whenComplete(() =>
                                        Navigator.pushNamed(context, '/map'));
                              },
                              child: Container(
                                height: 50,
                                width: 500,
                                decoration: const BoxDecoration(
                                    color: Color(0xff65BFB8),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    "Approve Campaign",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                          InkWell(
                              onTap: () {
                                context
                                    .read(authserviceProvider)
                                    .declineCampaign(snapshot.data!.id)
                                    .whenComplete(() =>
                                        Navigator.pushNamed(context, '/map'));
                              },
                              child: Container(
                                height: 50,
                                width: 500,
                                decoration: const BoxDecoration(
                                    color: Color(0xffFF673A),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    "Decline and Delete Request",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 190,
                    left: 50,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(urlTest),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 40, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.person,
                                size: 120,
                                color: Color(0xfffefefe),
                              ),
                              const Text(
                                // snapshot.data!.get('campaign_name'),
                                "Reforestation on Pantabangan!",
                                style: TextStyle(
                                    color: Color(0xff65BFB8),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data!.get('username'),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          } else {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ),
            );
          }
        });
  }
}
