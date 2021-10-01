import 'dart:io';
import 'dart:ui';
import 'zamanButonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'anasayfa.dart';
import 'insaat.dart';
import 'İnsaatWidgetlari.dart';
import 'atolye.dart';

void main() {
  runApp(oyunEkrani());
}

class oyunEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      home: harita(),
    );
  }
}

class harita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(

              color: Color(0x476E87CB),
              child: RotatedBox(
                quarterTurns: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                    SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        altbuton(text: 'Nüfus',),
                        altbuton(text: 'Asker Sayısı',),
                        altbuton(text: 'Muhafız Sayısı',),
                        altbuton(text: 'İsyancı Sayısı',),
                        altbuton(text: 'Kasa',),
                        geriButonu(anasayfa()),
                      ],
                    ),
                  ],
                ),
              )),
        ),
        Expanded(
          flex: 3,
          child: Column(children: [
            Container(
              child: Image.asset(
                "assets/yeni_harita.png",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: 277,
              height: 225,
              color: Color(0x476E87CB),
              child: RotatedBox(
                quarterTurns: 5,
                child: Wrap(
                  runSpacing: 3,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    zamanButon(
                      Icon(Icons.pause_circle_outline),),
                    zamanButon(
                      Icon(Icons.play_circle_outline_outlined),),
                    zamanButon(
                      Icon(Icons.reply_all_outlined),),
                    yanbuton(
                      sayfaCagirma: insaat(),
                      sayfaIsmi: 'İnsaat',
                    ),
                    yanbuton(
                      sayfaCagirma: sirketler(),
                      sayfaIsmi: 'Mağaza',
                    ),
                    yanbuton(
                      sayfaCagirma: sirketler(),
                      sayfaIsmi: 'Şirketler',
                    ),
                    yanbuton(
                      sayfaCagirma: anasayfa(),
                      sayfaIsmi: 'Sıralamalar',
                    ),
                    yanbuton(
                      sayfaCagirma: anasayfa(),
                      sayfaIsmi: 'Vergi',
                    ),
                    yanbuton(
                      sayfaCagirma: anasayfa(),
                      sayfaIsmi: 'Etkiler',
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class altbuton extends StatelessWidget {
  final text;
  altbuton({required this.text});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      color: Color(0xFFC21616),
      textColor: const Color(0xFF000000),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class yanbuton extends StatelessWidget {
  final sayfaCagirma;
  final sayfaIsmi;
  yanbuton({required this.sayfaCagirma, required this.sayfaIsmi});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text(sayfaIsmi,
            style: TextStyle(
                fontSize: 16
            )),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
        color: Color(0xFFC21616),
        textColor: const Color(0xFF000000),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => sayfaCagirma));
        });
  }
}
