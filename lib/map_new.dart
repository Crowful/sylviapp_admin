import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;

import 'package:latlong2/latlong.dart' as lt;

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
                              GestureDetector(
                                onTap: () => print("SUCCSS"),
                                child: null,
                              ) as fmap.CircleMarker,
                              fmap.CircleMarker(
                                  point: lt.LatLng(item.values.elementAt(0),
                                      item.values.elementAt(1)),
                                  radius: item.values.elementAt(2) * 100,
                                  color: Colors.red)
                            ],
                          ),
                        ),
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
