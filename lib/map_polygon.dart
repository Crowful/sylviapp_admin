import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPolygon extends StatefulWidget {
  const MapPolygon({Key? key}) : super(key: key);

  @override
  _MapPolygonState createState() => _MapPolygonState();
}

class _MapPolygonState extends State<MapPolygon> {
  LatLng? _initialCameraPosition = LatLng(14.5995, 120.9842);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(center: _initialCameraPosition, zoom: 13.0),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
          ),
        ],
      ),
    );
  }
}
