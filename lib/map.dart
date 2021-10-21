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
      final myLatlng = LatLng(1.3521, 103.8198);

      // another location
      final myLatlng2 = LatLng(1.4521, 103.9198);

      final mapOptions = MapOptions()
        ..zoom = 13
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
          final sirkel = Circle(CircleOptions()
            ..center = LatLng(doc['latitude'], doc['longitude'])
            ..map = map
            ..strokeWeight = 1.5
            ..strokeColor = "red"
            ..strokeOpacity = 0.2
            ..fillOpacity = 0.1
            ..fillColor = "red"
            ..radius = doc['radius']
            ..clickable = true);

          sirkel.onClick.listen((event) {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return ShowCampaign(campaignId: doc.id);
            }));
          });
        });
        //   Circle(CircleOptions()
        //     ..center = LatLng(doc['latitude'], doc['longitude'])
        //     ..map = map
        //     ..strokeWeight = 1.5
        //     ..strokeColor = "red"
        //     ..strokeOpacity = 0.2
        //     ..fillOpacity = 0.1
        //     ..fillColor = "red"
        //     ..radius = 500
        //     ..clickable = true
        //     );
        // });
      });

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}

var contentString = '<div id="content">' +
    '<div id="siteNotice">' +
    '</div>' +
    '<h1 id="firstHeading" class="firstHeading">Uluru</h1>' +
    '<div id="bodyContent">' +
    '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
    'sandstone rock formation in the southern part of the ' +
    'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) ' +
    'south west of the nearest large town, Alice Springs; 450&#160;km ' +
    '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major ' +
    'features of the Uluru - Kata Tjuta National Park. Uluru is ' +
    'sacred to the Pitjantjatjara and Yankunytjatjara, the ' +
    'Aboriginal people of the area. It has many springs, waterholes, ' +
    'rock caves and ancient paintings. Uluru is listed as a World ' +
    'Heritage Site.</p>' +
    '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">' +
    'https://en.wikipedia.org/w/index.php?title=Uluru</a> ' +
    '(last visited June 22, 2009).</p>' +
    '</div>' +
    '</div>';
