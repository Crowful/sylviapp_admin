import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/providers/providers.dart';

class MapPolygon extends StatefulWidget {
  const MapPolygon({Key? key}) : super(key: key);

  @override
  _MapPolygonState createState() => _MapPolygonState();
}

class _MapPolygonState extends State<MapPolygon> {
  double zooming = 5;
  LatLng? _initialCameraPosition = LatLng(14.5995, 120.9842);

  MapController _mapctl = MapController();
  List<LatLng> _PolygonLamesa = List.empty(growable: true);
  List<LatLng> _PolygonPantabangan = List.empty(growable: true);
  List<LatLng> _PolygonAngat = List.empty(growable: true);

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
                              _mapctl.move(
                                  LatLng(14.918990, 121.165563), zooming);
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
                                _mapctl.move(
                                    LatLng(14.7452, 121.0984), zooming);
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
                                _mapctl.move(
                                    LatLng(15.780574, 121.121838), zooming);
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
                                _mapctl.move(LatLng(15.780574, 121.121838), 13);
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
                                _mapctl.move(LatLng(14.7452, 121.0984), 13);
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
                                  primary: Color(0xff65BFB8))),
                        ),
                        SizedBox(
                          height: 70,
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () {
                                _mapctl.move(LatLng(14.918990, 121.165563), 13);
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
                                  primary: Color(0xff65BFB8))),
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
                                  primary: Color(0xffFFD54C))),
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
                                  primary: Color(0xff65BFB8))),
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
                            _mapctl.move(_mapctl.center, zooming);
                          });
                        })
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FlutterMap(
                  mapController: _mapctl,
                  options: MapOptions(
                    center: _initialCameraPosition,
                    zoom: zooming,
                    onLongPress: (tapPosition, point) {
                      if (isCreatingAngat == true) {
                        setState(() {
                          _PolygonAngat.add(
                              LatLng(point.latitude, point.longitude));
                        });
                        Fluttertoast.showToast(msg: "Point added");
                      } else if (isCreatingLamesa == true) {
                        setState(() {
                          _PolygonLamesa.add(
                              LatLng(point.latitude, point.longitude));
                        });
                        Fluttertoast.showToast(msg: "Point added");
                      } else if (isCreatingPantabangan == true) {
                        setState(() {
                          _PolygonPantabangan.add(
                              LatLng(point.latitude, point.longitude));
                        });
                        Fluttertoast.showToast(msg: "Point added");
                      } else {
                        Fluttertoast.showToast(msg: "Select forest first");
                      }

                      print(_PolygonAngat);
                    },
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Text("© OpenStreetMap contributors");
                      },
                    ),
                    PolygonLayerOptions(
                      polygons: [
                        Polygon(
                            points: _PolygonAngat,
                            isDotted: true,
                            color: Colors.green,
                            borderColor: Colors.green,
                            borderStrokeWidth: 2.0),
                        Polygon(
                            points: _PolygonLamesa,
                            isDotted: true,
                            color: Colors.yellow,
                            borderColor: Colors.yellow,
                            borderStrokeWidth: 2.0),
                        Polygon(
                            points: _PolygonPantabangan,
                            isDotted: true,
                            color: Colors.red,
                            borderColor: Colors.red,
                            borderStrokeWidth: 2.0)
                      ],
                    ),
                  ],
                ),
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
