import 'package:flutter/material.dart';

import 'functions.dart';

class zamanButon extends StatefulWidget {
  Icon ikon;
  zamanButon(this.ikon);
  @override
  _zamanButonState createState() => _zamanButonState();
}

class _zamanButonState extends State<zamanButon> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0x476E87CB),
      child: IconButton(
        onPressed: () {},
        alignment: Alignment.center,
        icon: widget.ikon,
        color: Colors.red,
      ),
    );
  }
}
