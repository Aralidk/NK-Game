import 'dart:ui';
import 'oyunEkrani.dart';
import 'İnsaatWidgetlari.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fonksiyonlar.dart';


void main() {
  runApp(insaat());
}

class insaat extends StatefulWidget {
  @override
  _insaatState createState() => _insaatState();
}

class _insaatState extends State<insaat> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 325,
            height: 600,
            color: Color(0x476E87CB),
            child: RotatedBox(
              quarterTurns: 5,
                child: Row(
                  children: [
                    geriButonu(oyunEkrani()),
                    Expanded(
                      child: Wrap(children: [
                        insaatAlertKisla(),
                        insaatAlertAtolye(),
                        insaatAlertCiftlik(),
                        insaatAlertTapinak(),
                        insaatAlertHastane(),
                        insaatAlertOkul(),
                        insaatAlertLiman(),

                      ]),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
  }
}

class insaatAlertKisla extends StatefulWidget {
  @override
  _insaatAlertKisla createState() => _insaatAlertKisla();
}

class _insaatAlertKisla extends State<insaatAlertKisla> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/kisla.png",
      ),
      textButonu("Kısla", "dasdasdasdas"),
    ]);
  }
}

class insaatAlertAtolye extends StatefulWidget {
  @override
  _insaatAlertAtolyeState createState() => _insaatAlertAtolyeState();
}

class _insaatAlertAtolyeState extends State<insaatAlertAtolye> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/atolye.png",
      ),
      textButonu("Atolye", "sdasdasdasdas",),
    ]);
  }
}

class insaatAlertCiftlik extends StatefulWidget {
  @override
  _insaatAlertCiftlikState createState() => _insaatAlertCiftlikState();
}

class _insaatAlertCiftlikState extends State<insaatAlertCiftlik> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      resimKutulari(
        resim: "assets/ciftlik.png",
      ),
      textButonu("Çiftlik", "sdasdasdasdas"),
    ]);
  }
}

class insaatAlertTapinak extends StatefulWidget {
  @override
  _insaatAlertTapinakState createState() => _insaatAlertTapinakState();
}

class _insaatAlertTapinakState extends State<insaatAlertTapinak> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/tapinak.png",
      ),
      textButonu("Tapinak", "sdasdasdasdas"),
    ]);
  }
}

class insaatAlertHastane extends StatefulWidget {
  @override
  _insaatAlertHastaneState createState() => _insaatAlertHastaneState();
}

class _insaatAlertHastaneState extends State<insaatAlertHastane> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/hastane.png",
      ),
      textButonu("Hastane", "sdasdasdasdas"),
    ]);
  }
}

class insaatAlertOkul extends StatefulWidget {
  const insaatAlertOkul({Key? key}) : super(key: key);

  @override
  _insaatAlertOkulState createState() => _insaatAlertOkulState();
}

class _insaatAlertOkulState extends State<insaatAlertOkul> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/okul.png",
      ),
      textButonu("Okul", "sdasdasdasdas"),
    ]);
  }
}

class insaatAlertLiman extends StatefulWidget {
  @override
  _insaatAlertLimanState createState() => _insaatAlertLimanState();
}

class _insaatAlertLimanState extends State<insaatAlertLiman> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/liman.png",
      ),
      textButonu("Liman", "sdasdasdasdas"),
    ]);
  }
}
