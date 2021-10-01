import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nkmanagetheworld/fonksiyonlar.dart';
import 'oyunEkrani.dart';
import 'ayarlar.dart';
import 'fonksiyonlar.dart';


class anasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    final screenSize = MediaQuery.of(context).size;
    return arkaplan(screenSize);
  }

  Container arkaplan(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/anasayfa.png'),
            fit: BoxFit.cover,
          )),
      child: ustKutu(),
    );
  }
}

class ustKutu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 540),
          child: butonlar(
            sayfalar: oyunEkrani(),
          ),
        ),
        Row(
          children: [
            butonkutusu(
              child: butonlar(
                sayfalar: HomePage(),
              ),
            ),
            butonkutusu(
              child: butonlar(
                sayfalar: ayarlar(),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class butonkutusu extends StatelessWidget {
  final child;
  butonkutusu({this.child});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          alignment: Alignment(-0.2, 1.2),
          height: 70,
          child: child,
        ));
  }
}

class butonlar extends StatelessWidget {
  final sayfalar;
  butonlar({required this.sayfalar});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      color: Colors.transparent,
      onPressed: () {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => sayfalar));
      },
    );
  }
}


