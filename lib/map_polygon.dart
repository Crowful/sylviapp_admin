import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart' as lt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylviapp_admin/animations/opaque.dart';
import 'package:sylviapp_admin/loginwrapper.dart';
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
  List<Map<String, dynamic>> circleMarkersCampaignsNonRequest =
      List.empty(growable: true);
  double zooming = 13;
  final lt.LatLng? _initialCameraPosition = lt.LatLng(14.5995, 120.9842);

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

  Timer _timer = Timer(const Duration(milliseconds: 1), () {});
  @override
  void initState() {
    _initializeTimer();
    FirebaseFirestore.instance
        .collection('polygon')
        .doc('Angat_Forest')
        .collection('polygons')
        .doc('1')
        .get()
        .then((value) {
      List<dynamic> test = value.get('points');
      for (var element in test) {
        _PolygonAngat.add(lt.LatLng(element['latitude'], element['longitude']));
      }
    });

    FirebaseFirestore.instance
        .collection('polygon')
        .doc('Lamesa_Forest')
        .collection('polygons')
        .doc('1')
        .get()
        .then((value) {
      List<dynamic> test = value.get('points');
      for (var element in test) {
        _PolygonLamesa.add(
            lt.LatLng(element['latitude'], element['longitude']));
      }
    });

    FirebaseFirestore.instance
        .collection('polygon')
        .doc('Pantabangan_Forest')
        .collection('polygons')
        .doc('1')
        .get()
        .then((value) {
      List<dynamic> test = value.get('points');
      for (var element in test) {
        _PolygonPantabangan.add(
            lt.LatLng(element['latitude'], element['longitude']));
      }
    });

    super.initState();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(const Duration(minutes: 2), () => _handleInactivity());
  }

  void _handleInactivity() async {
    _timer.cancel();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear().whenComplete(() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginWrapper())));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _initializeTimer();
      },
      onPanDown: (panDown) {
        _initializeTimer();
      },
      onPanUpdate: (panDown) {
        _initializeTimer();
      },
      child: Scaffold(
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
                                  cntrler.move(lt.LatLng(15.780574, 121.121838),
                                      zooming);
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
                                  cntrler.move(lt.LatLng(15.780574, 121.121838),
                                      zooming);
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
                                  cntrler.move(lt.LatLng(14.918990, 121.165563),
                                      zooming);
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                                  if (isCreatingAngat == true &&
                                      isCreatingLamesa == false &&
                                      isCreatingPantabangan == false) {
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
                                  } else if (isCreatingAngat == false &&
                                      isCreatingLamesa == true &&
                                      isCreatingPantabangan == false) {
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
                                  } else if (isCreatingAngat == false &&
                                      isCreatingLamesa == false &&
                                      isCreatingPantabangan == true) {
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
                              child: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return SizedBox(
                                  child: Slider(
                                      value: zooming,
                                      min: 1,
                                      max: 20,
                                      onChanged: (zoom1) {
                                        setState(() {
                                          zooming = zoom1;

                                          cntrler.move(cntrler.center, zoom1);
                                        });
                                      }),
                                );
                              }),
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
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 100,
                                        margin: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 7),
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
                                                    SizedBox(
                                                      width: 170,
                                                      child: Text(
                                                        e['campaign_name'],
                                                        style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
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
                                                            color: Color(
                                                                0xff65BFB8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    child: const Center(
                                                      child: Text(
                                                        'View in Map',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                            color: Color(
                                                                0xff65BFB8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                    child: const Center(
                                                      child: Text(
                                                        'Details',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("polygon")
                      .doc('Lamesa_Forest')
                      .collection('polygons')
                      .where('points', isNull: false)
                      .get(),
                  builder: (context, lamesa) {
                    if (!lamesa.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      for (var element in lamesa.data!.docs) {
                        latlng = List<dynamic>.from(element['points']);
                      }

                      for (var points in latlng) {
                        fromLamesaDB.add(
                            lt.LatLng(points['latitude'], points['longitude']));
                      }
                      return Expanded(
                        child: FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("polygon")
                                .doc('Angat_Forest')
                                .collection('polygons')
                                .where('points', isNull: false)
                                .get(),
                            builder: (context, angat) {
                              if (!angat.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                for (var angatPoints in angat.data!.docs) {
                                  latlng2 =
                                      List<dynamic>.from(angatPoints['points']);
                                }

                                for (var points in latlng2) {
                                  fromAngatDB.add(lt.LatLng(
                                      points['latitude'], points['longitude']));
                                }
                                return FutureBuilder<QuerySnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection("polygon")
                                        .doc('Pantabangan_Forest')
                                        .collection('polygons')
                                        .where('points', isNull: false)
                                        .get(),
                                    builder: (context, pantabangan) {
                                      if (!pantabangan.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        for (var pantabanganPoints
                                            in pantabangan.data!.docs) {
                                          latlng3 = List<dynamic>.from(
                                              pantabanganPoints['points']);
                                        }

                                        for (var points in latlng3) {
                                          fromAngatDB.add(lt.LatLng(
                                              points['latitude'],
                                              points['longitude']));
                                        }
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: FutureBuilder<QuerySnapshot>(
                                              future: FirebaseFirestore.instance
                                                  .collection(
                                                      "admin_campaign_requests")
                                                  .get(),
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
                                                        doc.get("radius") * 100;
                                                    var campaignUid = doc.id;
                                                    var orgId = doc.get('uid');

                                                    circleMarkersCampaigns.add({
                                                      "latitude":
                                                          campaignLat as double,
                                                      "longitude":
                                                          campaignLon as double,
                                                      "radius":
                                                          campaignRad as double,
                                                      "uid": campaignUid,
                                                      "userid": orgId
                                                    });
                                                  }
                                                  return FutureBuilder<
                                                          QuerySnapshot>(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "campaigns")
                                                          .get(),
                                                      builder: (context,
                                                          snapshotCampaign) {
                                                        if (snapshotCampaign
                                                            .hasData) {
                                                          for (var doc
                                                              in snapshotCampaign
                                                                  .data!.docs) {
                                                            doc.get("latitude");
                                                            var campaignLat =
                                                                doc.get(
                                                                    "latitude");
                                                            var campaignLon =
                                                                doc.get(
                                                                    "longitude");
                                                            var campaignRad =
                                                                doc.get("radius") *
                                                                    .2;
                                                            var campaignUid =
                                                                doc.id;
                                                            circleMarkersCampaignsNonRequest
                                                                .add({
                                                              "latitude":
                                                                  campaignLat
                                                                      as double,
                                                              "longitude":
                                                                  campaignLon
                                                                      as double,
                                                              "radius":
                                                                  campaignRad
                                                                      as double,
                                                              "uid": campaignUid
                                                            });
                                                          }
                                                          // circleMarkersCampaignsNonRequest =
                                                          return fmap
                                                              .FlutterMap(
                                                            mapController:
                                                                cntrler,
                                                            options:
                                                                fmap.MapOptions(
                                                              center:
                                                                  _initialCameraPosition,
                                                              zoom: zooming,
                                                              onLongPress:
                                                                  (tapPosition,
                                                                      point) {
                                                                if (isCreatingAngat ==
                                                                    true) {
                                                                  setState(() {
                                                                    _PolygonAngat.add(lt.LatLng(
                                                                        point
                                                                            .latitude,
                                                                        point
                                                                            .longitude));
                                                                  });
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Point added");
                                                                } else if (isCreatingLamesa ==
                                                                    true) {
                                                                  setState(() {
                                                                    _PolygonLamesa.add(lt.LatLng(
                                                                        point
                                                                            .latitude,
                                                                        point
                                                                            .longitude));
                                                                  });
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Point added");
                                                                } else if (isCreatingPantabangan ==
                                                                    true) {
                                                                  setState(() {
                                                                    _PolygonPantabangan.add(lt.LatLng(
                                                                        point
                                                                            .latitude,
                                                                        point
                                                                            .longitude));
                                                                  });
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Point added");
                                                                } else {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Select forest first");
                                                                }
                                                              },
                                                            ),
                                                            children: [
                                                              fmap.TileLayerWidget(
                                                                options: fmap
                                                                    .TileLayerOptions(
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
                                                                attributionBuilder:
                                                                    (_) {
                                                                  return const Text(
                                                                      "© OpenStreetMap contributors");
                                                                },
                                                              ),
                                                              fmap.PolygonLayerOptions(
                                                                polygons: [
                                                                  fmap.Polygon(
                                                                      points:
                                                                          _PolygonAngat,
                                                                      color: Colors
                                                                          .green
                                                                          .withOpacity(
                                                                              0.5),
                                                                      borderColor:
                                                                          Colors
                                                                              .green,
                                                                      borderStrokeWidth:
                                                                          0),
                                                                  fmap.Polygon(
                                                                      points:
                                                                          _PolygonLamesa,
                                                                      color: Colors
                                                                          .yellow
                                                                          .withOpacity(
                                                                              0.5),
                                                                      borderColor:
                                                                          Colors
                                                                              .yellow,
                                                                      borderStrokeWidth:
                                                                          2.0),
                                                                  fmap.Polygon(
                                                                      points:
                                                                          _PolygonPantabangan,
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.5),
                                                                      borderColor:
                                                                          Colors
                                                                              .red,
                                                                      borderStrokeWidth:
                                                                          2.0),
                                                                ],
                                                              ),
                                                              for (var item
                                                                  in circleMarkersCampaigns)
                                                                fmap.CircleLayerOptions(
                                                                  circles: [
                                                                    fmap.CircleMarker(
                                                                        point: lt.LatLng(
                                                                            item.values.elementAt(
                                                                                0),
                                                                            item.values.elementAt(
                                                                                1)),
                                                                        radius: item.values.elementAt(2) *
                                                                            .0050,
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(
                                                                                0.5),
                                                                        borderColor:
                                                                            Colors
                                                                                .red,
                                                                        borderStrokeWidth:
                                                                            1)
                                                                  ],
                                                                ),
                                                              for (var item
                                                                  in circleMarkersCampaignsNonRequest)
                                                                fmap.CircleLayerOptions(
                                                                  circles: [
                                                                    fmap.CircleMarker(
                                                                        point: lt.LatLng(
                                                                            item.values.elementAt(
                                                                                0),
                                                                            item.values.elementAt(
                                                                                1)),
                                                                        radius: item
                                                                            .values
                                                                            .elementAt(
                                                                                2),
                                                                        color: Colors
                                                                            .blue
                                                                            .withOpacity(
                                                                                0.5),
                                                                        borderColor:
                                                                            Colors
                                                                                .blue,
                                                                        borderStrokeWidth:
                                                                            1)
                                                                  ],
                                                                ),
                                                              for (var item
                                                                  in circleMarkersCampaigns)
                                                                fmap.MarkerLayerOptions(
                                                                    markers: [
                                                                      fmap.Marker(
                                                                          point: lt.LatLng(item.values.elementAt(0), item.values.elementAt(1)),
                                                                          builder: (context) {
                                                                            return FutureBuilder<DocumentSnapshot>(
                                                                                future: FirebaseFirestore.instance.collection("admin_campaign_requests").doc(item.values.elementAt(3)).get(),
                                                                                builder: (context, snapshot) {
                                                                                  if (!snapshot.hasData) {
                                                                                    return const Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    );
                                                                                  } else if (snapshot.hasError) {
                                                                                    return const Text('Error Occurred');
                                                                                  } else {
                                                                                    return InkWell(
                                                                                        onTap: () {
                                                                                          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                                                                                            return ShowCampaign(
                                                                                              campaignId: item.values.elementAt(3),
                                                                                              organizerId: item.values.elementAt(4),
                                                                                            );
                                                                                          }));
                                                                                        },
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
                                                              for (var item
                                                                  in circleMarkersCampaignsNonRequest)
                                                                fmap.MarkerLayerOptions(
                                                                    markers: [
                                                                      fmap.Marker(
                                                                          point: lt.LatLng(item.values.elementAt(0), item.values.elementAt(1)),
                                                                          builder: (context) {
                                                                            return FutureBuilder<DocumentSnapshot>(
                                                                                future: FirebaseFirestore.instance.collection("campaigns").doc(item.values.elementAt(3)).get(),
                                                                                builder: (context, snapshot) {
                                                                                  if (!snapshot.hasData) {
                                                                                    return const Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    );
                                                                                  } else {
                                                                                    return Tooltip(
                                                                                      message: item.values.elementAt(1).toString() + "  " + item.values.elementAt(0).toString(),
                                                                                      child: const Icon(
                                                                                        Icons.help_rounded,
                                                                                        color: Colors.transparent,
                                                                                        size: 13,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                });
                                                                          })
                                                                    ]),
                                                            ],
                                                          );
                                                        } else {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                      });
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
      ),
    );
  }
}
