import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as lt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/providers/providers.dart';
import 'package:sylviapp_admin/show_campaign_request.dart';

class MapPolygon extends StatefulWidget {
  const MapPolygon({Key? key}) : super(key: key);

  @override
  _MapPolygonState createState() => _MapPolygonState();
}

class _MapPolygonState extends State<MapPolygon> {
  List<Map<String, dynamic>> circleMarkersCampaigns =
      List.empty(growable: true);
  double zooming = 5;
  lt.LatLng? _initialCameraPosition = lt.LatLng(14.5995, 120.9842);

  fmap.MapController cntrler = fmap.MapController();
  List<lt.LatLng> _PolygonLamesa = List.empty(growable: true);
  List<lt.LatLng> _PolygonPantabangan = List.empty(growable: true);
  List<lt.LatLng> _PolygonAngat = List.empty(growable: true);

  List<lt.LatLng> fromAngatDB = List.empty(growable: true);
  List<lt.LatLng> fromPantabanganDB = List.empty(growable: true);
  List<lt.LatLng> fromLamesaDB = List.empty(growable: true);
  List<dynamic> latlng = List.empty(growable: true);
  List<dynamic> latlng2 = List.empty(growable: true);
  List<dynamic> latlng3 = List.empty(growable: true);
  bool isCreatingLamesa = false;
  bool isCreatingPantabangan = false;
  bool isCreatingAngat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Row(
          children: [
            Card(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 5,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 25,
                            )),
                        const Text('Create Polygon',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'View Forest',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 112,
                          child: ElevatedButton(
                            onPressed: () {
                              cntrler.move(
                                  lt.LatLng(14.918990, 121.165563), zooming);
                            },
                            child: const Center(
                                child: Text(
                              "Angat Forest",
                              style: TextStyle(fontSize: 13),
                            )),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff65BFB8)),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 112,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(14.7452, 121.0984), zooming);
                              },
                              child: const Text(
                                "Lamesa Forest",
                                style: TextStyle(fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 50,
                          width: 112,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(15.780574, 121.121838), zooming);
                              },
                              child: const Text(
                                "Pantabangan Forest",
                                style: TextStyle(fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Create Polygon Points',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 112,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(15.780574, 121.121838), zooming);
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_LONG,
                                    timeInSecForIosWeb: 5,
                                    webShowClose: true,
                                    msg:
                                        "Pantabangan Polygon Creation enabled : Long Press in the map to create points.");
                                setState(() {
                                  isCreatingAngat = false;
                                  isCreatingLamesa = false;
                                  isCreatingPantabangan = true;
                                });
                              },
                              child: const Text(
                                "In \nPantabangan",
                                style: TextStyle(fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 50,
                          width: 112,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(14.7452, 121.0984), zooming);
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_LONG,
                                    timeInSecForIosWeb: 5,
                                    webShowClose: true,
                                    msg:
                                        "Lamesa Polygon Creation enabled : Long Press in the map to create points.");
                                setState(() {
                                  isCreatingAngat = false;
                                  isCreatingLamesa = true;
                                  isCreatingPantabangan = false;
                                });
                              },
                              child: const Text(
                                "In Lamesa",
                                style: TextStyle(fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 50,
                          width: 112,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(14.918990, 121.165563), zooming);
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_LONG,
                                    timeInSecForIosWeb: 5,
                                    webShowClose: true,
                                    msg:
                                        "Angat Polygon Creation enabled : Long Press in the map to create points.");
                                setState(() {
                                  isCreatingAngat = true;
                                  isCreatingLamesa = false;
                                  isCreatingPantabangan = false;
                                });
                              },
                              child: const Text(
                                "In Angat",
                                style: TextStyle(fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Controls',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () {
                                if (isCreatingAngat == true) {
                                  setState(() {
                                    _PolygonAngat.removeLast();
                                  });
                                } else if (isCreatingLamesa == true) {
                                  setState(() {
                                    _PolygonLamesa.removeLast();
                                  });
                                } else if (isCreatingPantabangan == true) {
                                  setState(() {
                                    _PolygonPantabangan.removeLast();
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Select forest first");
                                }
                              },
                              child: const Text("Undo"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffFFD54C))),
                        ),
                        SizedBox(
                          height: 40,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () {
                                if (isCreatingAngat == true) {
                                  iteratePointsPolygonAngat() {
                                    dynamic polymap = _PolygonAngat.map((e) {
                                      return {
                                        "latitude": e.latitude,
                                        "longitude": e.longitude
                                      };
                                    });
                                    return polymap;
                                  }

                                  context
                                      .read(authserviceProvider)
                                      .createPolygon("Angat_Forest",
                                          iteratePointsPolygonAngat());
                                } else if (isCreatingLamesa == true) {
                                  iteratePointsPolygonLamesa() {
                                    dynamic polymap = _PolygonLamesa.map((e) {
                                      return {
                                        "latitude": e.latitude,
                                        "longitude": e.longitude
                                      };
                                    });
                                    return polymap;
                                  }

                                  context
                                      .read(authserviceProvider)
                                      .createPolygon("Lamesa_Forest",
                                          iteratePointsPolygonLamesa());
                                } else if (isCreatingPantabangan == true) {
                                  iteratePointsPolygonPantabangan() {
                                    dynamic polymap =
                                        _PolygonPantabangan.map((e) {
                                      return {
                                        "latitude": e.latitude,
                                        "longitude": e.longitude
                                      };
                                    });
                                    return polymap;
                                  }

                                  context
                                      .read(authserviceProvider)
                                      .createPolygon("Pantabangan_Forest",
                                          iteratePointsPolygonPantabangan());
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Select forest first");
                                }
                              },
                              child: const Text("Save"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 40,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () {
                                if (isCreatingAngat == true) {
                                  setState(() {
                                    _PolygonAngat.clear();
                                  });
                                } else if (isCreatingLamesa == true) {
                                  setState(() {
                                    _PolygonLamesa.clear();
                                  });
                                } else if (isCreatingPantabangan == true) {
                                  setState(() {
                                    _PolygonPantabangan.clear();
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Select forest first");
                                }
                              },
                              child: const Text("Clear")),
                        ),
                        SizedBox(
                          height: 40,
                          width: 80,
                          child: ElevatedButton(
                            onPressed: () {
                              if (isCreatingAngat == true) {
                                setState(() {
                                  _PolygonAngat.clear();
                                  isCreatingAngat = false;
                                  isCreatingLamesa = false;
                                  isCreatingPantabangan = false;
                                });
                              } else if (isCreatingLamesa == true) {
                                setState(() {
                                  _PolygonLamesa.clear();
                                  isCreatingAngat = false;
                                  isCreatingLamesa = false;
                                  isCreatingPantabangan = false;
                                });
                              } else if (isCreatingPantabangan == true) {
                                setState(() {
                                  _PolygonPantabangan.clear();
                                  isCreatingAngat = false;
                                  isCreatingLamesa = false;
                                  isCreatingPantabangan = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Select forest first");
                              }
                            },
                            child: const Text(
                              "Cancel",
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xffFF673A)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        children: [
                          const Text(
                            'Zoom',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Slider(
                                  value: zooming,
                                  min: 1,
                                  max: 20,
                                  onChanged: (zoom1) {
                                    setState(() {
                                      zooming = zoom1;
                                      cntrler.move(cntrler.center, zooming);
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Manage Campaign Requests',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('admin_campaign_requests')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xff65BFB8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: snapshot.data!.docs.map((e) {
                                    String campaignAddress = e['address'];
                                    String campaignID = e['campaignID'];
                                    String campaignName = e['campaign_name'];
                                    String campaignCity = e['city'];
                                    double campaignCurrentDonation =
                                        e['current_donations'];
                                    int campaignCurrentVolunteers =
                                        e['current_volunteers'];
                                    String campaignDateCreated =
                                        e['date_created'];
                                    String campaignDateEnded = e['date_ended'];
                                    String campaignDateStart = e['date_start'];
                                    String campaignDescription =
                                        e['description'];
                                    double campaignLatitude = e['latitude'];
                                    double campaignlongitude = e['longitude'];
                                    double campaignMaxDonation =
                                        e['max_donation'];
                                    int campaignNumberOfSeeds =
                                        e['number_of_seeds'];
                                    int campaignNumberVolunteers =
                                        e['number_volunteers'];
                                    String campaignTime = e['time'];
                                    String campaignUID = e['uid'];
                                    String campaignUsername = e['username'];

                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 100,
                                      margin:
                                          const EdgeInsets.fromLTRB(5, 5, 5, 7),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.5)),
                                          color: Colors.white,
                                          boxShadow: []),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    e['city'],
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    e['username'],
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  cntrler.move(
                                                      lt.LatLng(e['latitude'],
                                                          e['longitude']),
                                                      zooming);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xff65BFB8),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: const Center(
                                                    child: Text(
                                                      'View in Map',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      HeroDialogRoute(
                                                          builder: (context) {
                                                    return ShowCampaign(
                                                        campaignId:
                                                            e["campaignID"]);
                                                  }));
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color(0xff65BFB8),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: const Center(
                                                    child: Text(
                                                      'Details',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("polygon")
                    .doc('Lamesa_Forest')
                    .snapshots(),
                builder: (context, lamesa) {
                  if (!lamesa.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    latlng = List<dynamic>.from(lamesa.data!["points"]);
                    for (var points in latlng) {
                      fromLamesaDB.add(
                          lt.LatLng(points['latitude'], points['longitude']));
                    }
                    return Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("polygon")
                              .doc('Angat_Forest')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<DocumentSnapshot> angat) {
                            if (!angat.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              latlng2 =
                                  List<dynamic>.from(angat.data!["points"]);
                              for (var points in latlng2) {
                                fromAngatDB.add(lt.LatLng(
                                    points['latitude'], points['longitude']));
                              }
                              return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("polygon")
                                      .doc('Pantabangan_Forest')
                                      .snapshots(),
                                  builder: (context, pantabangan) {
                                    if (!pantabangan.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      latlng3 = List<dynamic>.from(
                                          pantabangan.data!["points"]);
                                      for (var points in latlng3) {
                                        fromPantabanganDB.add(lt.LatLng(
                                            points['latitude'],
                                            points['longitude']));
                                      }
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                    "admin_campaign_requests")
                                                .get()
                                                .asStream(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else {
                                                for (var doc
                                                    in snapshot.data!.docs) {
                                                  var campaignLat =
                                                      doc.get("latitude");
                                                  var campaignLon =
                                                      doc.get("longitude");
                                                  var campaignRad =
                                                      doc.get("radius");
                                                  var campaignUid = doc.id;

                                                  circleMarkersCampaigns.add({
                                                    "latitude":
                                                        campaignLat as double,
                                                    "longitude":
                                                        campaignLon as double,
                                                    "radius":
                                                        campaignRad as double,
                                                    "uid": campaignUid
                                                  });
                                                }
                                                return fmap.FlutterMap(
                                                  mapController: cntrler,
                                                  options: fmap.MapOptions(
                                                    center:
                                                        _initialCameraPosition,
                                                    zoom: zooming,
                                                    onLongPress:
                                                        (tapPosition, point) {
                                                      if (isCreatingAngat ==
                                                          true) {
                                                        setState(() {
                                                          _PolygonAngat.add(
                                                              lt.LatLng(
                                                                  point
                                                                      .latitude,
                                                                  point
                                                                      .longitude));
                                                        });
                                                        Fluttertoast.showToast(
                                                            msg: "Point added");
                                                      } else if (isCreatingLamesa ==
                                                          true) {
                                                        setState(() {
                                                          _PolygonLamesa.add(
                                                              lt.LatLng(
                                                                  point
                                                                      .latitude,
                                                                  point
                                                                      .longitude));
                                                        });
                                                        Fluttertoast.showToast(
                                                            msg: "Point added");
                                                      } else if (isCreatingPantabangan ==
                                                          true) {
                                                        setState(() {
                                                          _PolygonPantabangan
                                                              .add(lt.LatLng(
                                                                  point
                                                                      .latitude,
                                                                  point
                                                                      .longitude));
                                                        });
                                                        Fluttertoast.showToast(
                                                            msg: "Point added");
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Select forest first");
                                                      }
                                                    },
                                                  ),
                                                  children: [
                                                    fmap.TileLayerWidget(
                                                      options:
                                                          fmap.TileLayerOptions(
                                                        urlTemplate:
                                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                        subdomains: [
                                                          'a',
                                                          'b',
                                                          'c'
                                                        ],
                                                        attributionBuilder:
                                                            (_) {
                                                          return const Text(
                                                              "© OpenStreetMap contributors");
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                  layers: [
                                                    fmap.TileLayerOptions(
                                                      urlTemplate:
                                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                      subdomains: [
                                                        'a',
                                                        'b',
                                                        'c'
                                                      ],
                                                      attributionBuilder: (_) {
                                                        return const Text(
                                                            "© OpenStreetMap contributors");
                                                      },
                                                    ),
                                                    fmap.PolygonLayerOptions(
                                                      polygons: [
                                                        fmap.Polygon(
                                                            points:
                                                                _PolygonAngat,
                                                            color: Colors.green
                                                                .withOpacity(
                                                                    0.5),
                                                            borderColor:
                                                                Colors.green,
                                                            borderStrokeWidth:
                                                                0),
                                                        fmap.Polygon(
                                                            points:
                                                                _PolygonLamesa,
                                                            color: Colors.yellow
                                                                .withOpacity(
                                                                    0.5),
                                                            borderColor:
                                                                Colors.yellow,
                                                            borderStrokeWidth:
                                                                2.0),
                                                        fmap.Polygon(
                                                            points:
                                                                _PolygonPantabangan,
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.5),
                                                            borderColor:
                                                                Colors.red,
                                                            borderStrokeWidth:
                                                                2.0),
                                                        fmap.Polygon(
                                                            points: fromAngatDB,
                                                            color: Colors.yellow
                                                                .withOpacity(
                                                                    0.5),
                                                            borderColor:
                                                                Colors.yellow,
                                                            borderStrokeWidth:
                                                                2),
                                                        fmap.Polygon(
                                                            points:
                                                                fromPantabanganDB,
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.5),
                                                            borderColor:
                                                                Colors.red,
                                                            borderStrokeWidth:
                                                                2),
                                                        fmap.Polygon(
                                                            points:
                                                                fromLamesaDB,
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.5),
                                                            borderColor:
                                                                Colors.blue,
                                                            borderStrokeWidth:
                                                                2),
                                                      ],
                                                    ),
                                                    for (var item
                                                        in circleMarkersCampaigns)
                                                      fmap.CircleLayerOptions(
                                                        circles: [
                                                          fmap.CircleMarker(
                                                              point: lt.LatLng(
                                                                  item.values
                                                                      .elementAt(
                                                                          0),
                                                                  item.values
                                                                      .elementAt(
                                                                          1)),
                                                              radius: item
                                                                      .values
                                                                      .elementAt(
                                                                          2) *
                                                                  100,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderColor:
                                                                  Colors.red,
                                                              borderStrokeWidth:
                                                                  1)
                                                        ],
                                                      ),
                                                    for (var item
                                                        in circleMarkersCampaigns)
                                                      fmap.MarkerLayerOptions(
                                                          markers: [
                                                            fmap.Marker(
                                                                point: lt.LatLng(
                                                                    item.values
                                                                        .elementAt(
                                                                            0),
                                                                    item.values
                                                                        .elementAt(
                                                                            1)),
                                                                builder:
                                                                    (context) {
                                                                  return StreamBuilder<
                                                                          DocumentSnapshot>(
                                                                      stream: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "admin_campaign_requests")
                                                                          .doc(item.values.elementAt(
                                                                              3))
                                                                          .snapshots(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return const Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          );
                                                                        } else {
                                                                          return InkWell(
                                                                              onTap: () {
                                                                                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                                                                                  return ShowCampaign(campaignId: item.values.elementAt(3));
                                                                                }));
                                                                              },
                                                                              // onHover: (hover) {
                                                                              //   Navigator.of(context).push(
                                                                              //       HeroDialogRoute(
                                                                              //           builder: (context) {
                                                                              //     return ShowCampaign(
                                                                              //         campaignId: item
                                                                              //             .values
                                                                              //             .elementAt(3));
                                                                              //   }));
                                                                              // },
                                                                              child: Tooltip(
                                                                                message: item.values.elementAt(1).toString() + "  " + item.values.elementAt(0).toString(),
                                                                                child: const Icon(
                                                                                  Icons.help_rounded,
                                                                                  color: Colors.transparent,
                                                                                  size: 13,
                                                                                ),
                                                                              ));
                                                                        }
                                                                      });
                                                                })
                                                          ]),
                                                  ],
                                                );
                                              }
                                            }),
                                      );
                                    }
                                  });
                            }
                          }),
                    );
                  }
                }),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 100,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Legends",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
