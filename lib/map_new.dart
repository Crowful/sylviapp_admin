import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:latlong2/latlong.dart' as lt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/providers/providers.dart';

class MapCampaignRequest extends StatefulWidget {
  const MapCampaignRequest({Key? key}) : super(key: key);

  @override
  _MapCampaignRequestState createState() => _MapCampaignRequestState();
}

class _MapCampaignRequestState extends State<MapCampaignRequest> {
  lt.LatLng? _initialCameraPosition = lt.LatLng(14.7452, 121.0984);

  List<Map<String, dynamic>> circleMarkersCampaigns =
      List.empty(growable: true);

  fmap.MapController cntrler = fmap.MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("admin_campaign_requests")
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              snapshot.data!.docs.forEach((doc) {
                var campaignLat = doc.get("latitude");
                var campaignLon = doc.get("longitude");
                var campaignRad = doc.get("radius");
                var campaignUid = doc.id;

                circleMarkersCampaigns.add({
                  "latitude": campaignLat as double,
                  "longitude": campaignLon as double,
                  "radius": campaignRad as double,
                  "uid": campaignUid
                });
              });
              return Stack(children: [
                fmap.FlutterMap(
                    mapController: cntrler,
                    options: fmap.MapOptions(
                      center: _initialCameraPosition,
                      zoom: 13,
                    ),
                    layers: [],
                    children: [
                      fmap.TileLayerWidget(
                        options: fmap.TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                          attributionBuilder: (_) {
                            return Text("© OpenStreetMap contributors");
                          },
                        ),
                      ),
                      for (var item in circleMarkersCampaigns)
                        fmap.CircleLayerWidget(
                          options: fmap.CircleLayerOptions(
                            circles: [
                              fmap.CircleMarker(
                                  point: lt.LatLng(item.values.elementAt(0),
                                      item.values.elementAt(1)),
                                  radius: item.values.elementAt(2) * 100,
                                  color: Colors.red)
                            ],
                          ),
                        ),
                      for (var item in circleMarkersCampaigns)
                        fmap.MarkerLayerWidget(
                          options: fmap.MarkerLayerOptions(markers: [
                            fmap.Marker(
                                point: lt.LatLng(item.values.elementAt(0),
                                    item.values.elementAt(1)),
                                builder: (context) {
                                  return StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("admin_campaign_requests")
                                          .doc(item.values.elementAt(3))
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        100, 100, 100, 100),
                                                    child: Card(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              snapshot.data!.get(
                                                                  'campaign_name'),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff65BFB8),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      30)),
                                                          Text(snapshot.data!
                                                              .get('address')),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'campaignID')),
                                                          Text(snapshot.data!
                                                              .get('city')),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'current_donations')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'current_volunteers')
                                                              .toString()),
                                                          Text(snapshot.data!.get(
                                                              'date_created')),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'date_ended')),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'date_start')),
                                                          Text(snapshot.data!.get(
                                                              'description')),
                                                          Text(snapshot.data!
                                                              .get('latitude')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get('longitude')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'max_donation')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'number_of_seeds')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get(
                                                                  'number_volunteers')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get('radius')
                                                              .toString()),
                                                          Text(snapshot.data!
                                                              .get('time')),
                                                          Text(snapshot.data!
                                                              .get('uid')),
                                                          Text(snapshot.data!
                                                              .get('username')),
                                                          SizedBox(
                                                            height: 50,
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                context
                                                                    .read(
                                                                        authserviceProvider)
                                                                    .createCampaign(
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'campaign_name'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'description'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'campaignID'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'date_created'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'date_start'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'date_ended'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'address'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'city'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'time'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'uid'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'username'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'latitude'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'longitude'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'number_of_seeds'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'current_donations'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'max_donation'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'current_volunteers'),
                                                                        snapshot
                                                                            .data!
                                                                            .get(
                                                                                'number_volunteers'))
                                                                    .whenComplete(() =>
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '/map'));
                                                              },
                                                              child: Text(
                                                                  "Approve This Campaign")),
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .red),
                                                              onPressed: () {
                                                                context
                                                                    .read(
                                                                        authserviceProvider)
                                                                    .declineCampaign(
                                                                        snapshot
                                                                            .data!
                                                                            .id)
                                                                    .whenComplete(() =>
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '/new_map'));
                                                              },
                                                              child: Text(
                                                                  "Decline This Campaign")),
                                                          ElevatedButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child:
                                                                  Text("Back"))
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            child: Icon(
                                              Icons.circle_outlined,
                                              size: item.values.elementAt(2) *
                                                  100,
                                            ),
                                          );
                                        }
                                      });
                                })
                          ]),
                        )
                    ]),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          cntrler.move(lt.LatLng(15.780574, 121.121838), 13);
                        },
                        child: Text("to pantabangan")),
                    ElevatedButton(
                        onPressed: () {
                          cntrler.move(lt.LatLng(14.7452, 121.0984), 13);
                        },
                        child: Text("to lamesa")),
                    ElevatedButton(
                        onPressed: () {
                          cntrler.move(lt.LatLng(14.918990, 121.16556), 13);
                        },
                        child: Text("to angat")),
                  ],
                ),
              ]);
            }
          }),
    );
  }
}
