import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fmap;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart' as lt;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/providers/providers.dart';

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
                                fontSize: 30, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'View Forest',
                      style: TextStyle(
                        fontSize: 30,
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
                          height: 70,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              cntrler.move(
                                  lt.LatLng(14.918990, 121.165563), zooming);
                            },
                            child: const Center(child: Text("Angat Forest")),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff65BFB8)),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(14.7452, 121.0984), zooming);
                              },
                              child: const Text("Lamesa Forest"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 70,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                                cntrler.move(
                                    lt.LatLng(15.780574, 121.121838), zooming);
                              },
                              child: const Text("Pantabangan Forest"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'Create Polygon Points',
                      style: TextStyle(
                        fontSize: 30,
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
                          height: 70,
                          width: 150,
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
                              child: const Text("In Pantabangan"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 70,
                          width: 150,
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
                              child: const Text("In Lamesa"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 70,
                          width: 150,
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
                              child: const Text("In Angat"),
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff65BFB8))),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'Controls',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
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
                          height: 50,
                          width: 100,
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
                          height: 50,
                          width: 100,
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
                          height: 50,
                          width: 100,
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
                    const Text(
                      'Zoom',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                        value: zooming,
                        min: 1,
                        max: 20,
                        onChanged: (zoom1) {
                          setState(() {
                            zooming = zoom1;
                            cntrler.move(cntrler.center, zooming);
                          });
                        }),
                    const Text('Manage Campaign Requests',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('admin_campaign_requests')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xff65BFB8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
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
                                  String campaignDateCreated =
                                      e['date_created'];
                                  String campaignDateEnded = e['date_ended'];
                                  String campaignDateStart = e['date_start'];
                                  String campaignDescription = e['description'];
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
                                    padding: const EdgeInsets.all(20),
                                    height: 100,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 7),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
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
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                cntrler.move(
                                                    lt.LatLng(e['latitude'],
                                                        e['longitude']),
                                                    zooming);
                                              },
                                              child: Container(
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff65BFB8),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                width: 100,
                                                child: const Center(
                                                  child: Text(
                                                    'View in Map',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                width: 100,
                                                child: const Center(
                                                  child: Text(
                                                    'Campaign',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                        })
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("admin_campaign_requests")
                        .get()
                        .asStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
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
                        return fmap.FlutterMap(
                          mapController: cntrler,
                          options: fmap.MapOptions(
                            center: _initialCameraPosition,
                            zoom: zooming,
                            onLongPress: (tapPosition, point) {
                              if (isCreatingAngat == true) {
                                setState(() {
                                  _PolygonAngat.add(lt.LatLng(
                                      point.latitude, point.longitude));
                                });
                                Fluttertoast.showToast(msg: "Point added");
                              } else if (isCreatingLamesa == true) {
                                setState(() {
                                  _PolygonLamesa.add(lt.LatLng(
                                      point.latitude, point.longitude));
                                });
                                Fluttertoast.showToast(msg: "Point added");
                              } else if (isCreatingPantabangan == true) {
                                setState(() {
                                  _PolygonPantabangan.add(lt.LatLng(
                                      point.latitude, point.longitude));
                                });
                                Fluttertoast.showToast(msg: "Point added");
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Select forest first");
                              }

                              print(_PolygonAngat);
                            },
                          ),
                          children: [
                            fmap.TileLayerWidget(
                              options: fmap.TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'],
                                attributionBuilder: (_) {
                                  return const Text(
                                      "© OpenStreetMap contributors");
                                },
                              ),
                            ),
                            for (var item in circleMarkersCampaigns)
                              fmap.CircleLayerWidget(
                                options: fmap.CircleLayerOptions(
                                  circles: [
                                    fmap.CircleMarker(
                                        point: lt.LatLng(
                                            item.values.elementAt(0),
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
                                                .collection(
                                                    "admin_campaign_requests")
                                                .doc(item.values.elementAt(3))
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                return GestureDetector(
                                                  onTap: () => showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  100,
                                                                  100,
                                                                  100,
                                                                  100),
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
                                                                    snapshot
                                                                        .data!
                                                                        .get(
                                                                            'campaign_name'),
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xff65BFB8),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            30)),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'address')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'campaignID')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'city')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'current_donations')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'current_volunteers')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'date_created')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'date_ended')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'date_start')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'description')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'latitude')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'longitude')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'max_donation')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'number_of_seeds')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'number_volunteers')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'radius')
                                                                    .toString()),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'time')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'uid')),
                                                                Text(snapshot
                                                                    .data!
                                                                    .get(
                                                                        'username')),
                                                                const SizedBox(
                                                                  height: 50,
                                                                ),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read(
                                                                              authserviceProvider)
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
                                                                              snapshot.data!.get('current_volunteers'),
                                                                              snapshot.data!.get('number_volunteers'))
                                                                          .whenComplete(() => Navigator.pushNamed(context, '/map'));
                                                                    },
                                                                    child: const Text(
                                                                        "Approve This Campaign")),
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors
                                                                                .red),
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read(
                                                                              authserviceProvider)
                                                                          .declineCampaign(snapshot
                                                                              .data!
                                                                              .id)
                                                                          .whenComplete(() => Navigator.pushNamed(
                                                                              context,
                                                                              '/new_map'));
                                                                    },
                                                                    child: const Text(
                                                                        "Decline This Campaign")),
                                                                ElevatedButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child: const Text(
                                                                        "Back"))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                  child: Icon(
                                                    Icons.circle_outlined,
                                                    size: item.values
                                                            .elementAt(2) *
                                                        100,
                                                  ),
                                                );
                                              }
                                            });
                                      })
                                ]),
                              )
                          ],
                          layers: [
                            fmap.TileLayerOptions(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                              attributionBuilder: (_) {
                                return const Text(
                                    "© OpenStreetMap contributors");
                              },
                            ),
                            fmap.PolygonLayerOptions(
                              polygons: [
                                fmap.Polygon(
                                    points: _PolygonAngat,
                                    isDotted: true,
                                    color: Colors.green.withOpacity(0.5),
                                    borderColor: Colors.green,
                                    borderStrokeWidth: 2.0),
                                fmap.Polygon(
                                    points: _PolygonLamesa,
                                    isDotted: true,
                                    color: Colors.yellow.withOpacity(0.5),
                                    borderColor: Colors.yellow,
                                    borderStrokeWidth: 2.0),
                                fmap.Polygon(
                                    points: _PolygonPantabangan,
                                    isDotted: true,
                                    color: Colors.red.withOpacity(0.5),
                                    borderColor: Colors.red,
                                    borderStrokeWidth: 2.0)
                              ],
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [],
          ),
        )
      ]),
    );
  }
}
