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
        FlutterMap(
          mapController: _mapctl,
          options: MapOptions(
            center: _initialCameraPosition,
            zoom: 5,
            onLongPress: (tapPosition, point) {
              if (isCreatingAngat == true) {
                setState(() {
                  _PolygonAngat.add(LatLng(point.latitude, point.longitude));
                });
                Fluttertoast.showToast(msg: "Point added");
              } else if (isCreatingLamesa == true) {
                setState(() {
                  _PolygonLamesa.add(LatLng(point.latitude, point.longitude));
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
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(14.5995, 120.9842),
                  builder: (ctx) => Container(
                    child: Icon(Icons.control_point),
                  ),
                ),
              ],
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
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 500, 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin_home");
                  },
                  child: Text("Back"),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  _mapctl.move(LatLng(14.918990, 121.165563), 13);
                },
                child: Text("Go to Angat Forest"),
                style: ElevatedButton.styleFrom(primary: Color(0xff65BFB8)),
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    _mapctl.move(LatLng(14.7452, 121.0984), 13);
                  },
                  child: Text("Go to Lamesa Forest"),
                  style: ElevatedButton.styleFrom(primary: Color(0xff65BFB8))),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    _mapctl.move(LatLng(15.780574, 121.121838), 13);
                  },
                  child: Text("Go to Pantabangan Forest"),
                  style: ElevatedButton.styleFrom(primary: Color(0xff65BFB8))),
              SizedBox(
                width: 50,
              ),
              ElevatedButton(
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
                  child: Text("Create Polygon in Pantabangan"),
                  style: ElevatedButton.styleFrom(primary: Color(0xff65BFB8))),
              ElevatedButton(
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
                  child: Text("Create Polygon in Lamesa"),
                  style: ElevatedButton.styleFrom(primary: Color(0xff65BFB8))),
              ElevatedButton(
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
                  child: Text("Create Polygon in Angat"),
                  style: ElevatedButton.styleFrom(primary: Color(0xff65BFB8))),
              ElevatedButton(
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
                      Fluttertoast.showToast(msg: "Select forest first");
                    }
                  },
                  child: Text("Undo")),
              ElevatedButton(
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

                      context.read(authserviceProvider).createPolygon(
                          "Angat_Forest", iteratePointsPolygonAngat());
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

                      context.read(authserviceProvider).createPolygon(
                          "Lamesa_Forest", iteratePointsPolygonLamesa());
                    } else if (isCreatingPantabangan == true) {
                      iteratePointsPolygonPantabangan() {
                        dynamic polymap = _PolygonPantabangan.map((e) {
                          return {
                            "latitude": e.latitude,
                            "longitude": e.longitude
                          };
                        });
                        return polymap;
                      }

                      context.read(authserviceProvider).createPolygon(
                          "Pantabangan_Forest",
                          iteratePointsPolygonPantabangan());
                    } else {
                      Fluttertoast.showToast(msg: "Select forest first");
                    }
                  },
                  child: Text("Save")),
              ElevatedButton(
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
                      Fluttertoast.showToast(msg: "Select forest first");
                    }
                  },
                  child: Text("Cancel")),
            ],
          ),
        )
      ]),
    );
  }
}
