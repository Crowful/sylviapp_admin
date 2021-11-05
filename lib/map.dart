import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:google_maps/google_maps.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/show_campaign_request.dart';

class MapAdmin extends StatefulWidget {
  const MapAdmin({Key? key}) : super(key: key);

  @override
  _MapAdminState createState() => _MapAdminState();
}

class _MapAdminState extends State<MapAdmin> {
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = MapOptions()
        ..zoom = 14
        ..center = LatLng(14.7452, 121.0984);

      final elem = DivElement()
        ..children
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

      FirebaseFirestore.instance
          .collection('admin_campaign_requests')
          .get()
          .then((QuerySnapshot querySnapshot) {
        // ignore: avoid_function_literals_in_foreach_calls
        querySnapshot.docs.forEach((doc) {
          double thisisRadius = doc['radius'] * 100;
          final sirkel = Circle(CircleOptions()
            ..center = LatLng(doc['latitude'], doc['longitude'])
            ..map = map
            ..strokeWeight = 1.5
            ..strokeColor = "red"
            ..strokeOpacity = 0.2
            ..fillOpacity = 0.1
            ..fillColor = "red"
            ..radius = thisisRadius
            ..clickable = true);

          sirkel.onClick.listen((event) {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return ShowCampaign(campaignId: doc.id);
            }));
          });
        });
      });

      return elem;
    });

    return Scaffold(
        body: Stack(children: [
      HtmlElementView(viewType: htmlId),
      Container(
          margin: const EdgeInsets.fromLTRB(400, 400, 0, 0),
          child: ElevatedButton(onPressed: () {}, child: Text("TESTING"))),
    ]));
  }
}
