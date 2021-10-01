import 'package:flutter/material.dart';
import 'oyunEkrani.dart';
import 'İnsaatWidgetlari.dart';

void main(){
  runApp(sirketler());
}


class sirketler extends StatefulWidget {
  @override
  _sirketlerState createState() => _sirketlerState();
}

class _sirketlerState extends State<sirketler> {
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
                    yiyecekSirket(),
                    kumasSirketi(),
                    SizedBox(
                      width: 30,
                    ),
                    ilacSirketi(),
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

class yiyecekSirket extends StatefulWidget {
  @override
  _yiyecekSirket createState() => _yiyecekSirket();
}

class _yiyecekSirket extends State<yiyecekSirket> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/yiyecek_icecek_sirketi.png",
      ),
      textButonu("Yiyecek İçecek Şirketi", "dasdasdasdas"),
    ]);
  }
}


class kumasSirketi extends StatefulWidget {
  @override
  _kumasSirketi createState() => _kumasSirketi();
}

class _kumasSirketi extends State<kumasSirketi> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/kumas_sirketi.png",
      ),
      textButonu("Kumaş Şirketi", "dasdasdasdas"),
    ]);
  }
}

class ilacSirketi extends StatefulWidget {
  @override
  _ilacSirketi createState() => _ilacSirketi();
}

class _ilacSirketi extends State<ilacSirketi> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      resimKutulari(
        resim: "assets/ilac_sirketi.png",
      ),
      textButonu("İlaç Şirketi", "dasdasdasdas"),
    ]);
  }
}

