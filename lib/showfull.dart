// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ImageFullScreen extends StatefulWidget {
  final String imgLink;
  const ImageFullScreen({
    Key? key,
    required this.imgLink,
  }) : super(key: key);

  @override
  _ImageFullScreenState createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 1000,
          width: 1000,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              image: DecorationImage(
                  image: NetworkImage(widget.imgLink), fit: BoxFit.contain)),
        ));
  }
}
