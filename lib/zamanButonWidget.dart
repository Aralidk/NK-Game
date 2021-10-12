import 'package:flutter/material.dart';
class zamanButon extends StatefulWidget {
  Icon ikon;
  zamanButon(this.ikon);
  @override
  _zamanButonState createState() => _zamanButonState();
}

class _zamanButonState extends State<zamanButon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        alignment: Alignment.center,
        icon: widget.ikon,
        color: Colors.red,
      );
  }
}
