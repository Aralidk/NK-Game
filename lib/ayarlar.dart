import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ayarlar extends StatefulWidget {
  @override
  _ayarlarState createState() => _ayarlarState();
}

class _ayarlarState extends State<ayarlar> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
      ]);

    return Container(
      color: Color(0x476E87CB),
      child: Column(
        children: [
          ayarlarKutu(
            Icon(
              Icons.volume_down_outlined,
              size: 100,
              color: Colors.white,
            ),),
        ],
      ),
    );
  }
}

class ayarlarKutu extends StatelessWidget {
  Icon ayarlarIkon;
  ayarlarKutu(this.ayarlarIkon);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: ayarlarIkon,
    );
  }
}



