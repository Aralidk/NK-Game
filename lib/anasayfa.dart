import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'oyunEkrani.dart';
import 'ayarlar.dart';


class AnaSayfa extends StatelessWidget {
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
      child: UstKutu(),
    );
  }
}

class UstKutu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        Row(
          children: [
            Expanded(child: butonlar(sayfalar: ayarlar(), anaSayfaButon:"assets/2.png")),
            Expanded(
              child: butonlar(
                anaSayfaButon: "assets/1.png",
                sayfalar: OyunEkrani(),),),
            Expanded(
              child: butonlar(
                anaSayfaButon: "assets/3.png",
                sayfalar: ayarlar(),
              ),
            )
          ],
        );
  }
}

class butonlar extends StatelessWidget {
  final sayfalar;
  final anaSayfaButon;
  butonlar({required this.sayfalar, required this.anaSayfaButon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(anaSayfaButon,),
            ),
          ),),
        onTap:(){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => sayfalar));}
    );
  }
}


