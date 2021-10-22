import 'package:flutter/material.dart';
import 'Widgetlar.dart';
import 'oyunEkrani.dart';

class Siralama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0),
      body: Center(
        child: Container(
          width: 325,
          height: 600,
          color: Color(0x476E87CB),
          child: RotatedBox(
            quarterTurns: 5,
            child: Row(children: [
              GeriButonu(OyunEkrani()),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 5,
                  children: [
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                    siralamaKartlari(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class siralamaKartlari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 400,
      height: 30,
      color: Color(0x476E87CB),
      child: ulkeSiralamaAciklama(
        ulkeAdi: 'Ulke Adı ',
        SiralamaAciklama: 'Bu ulke bundan dolayı su sırada',
      )

    );
  }
}

class ulkeSiralamaAciklama extends StatelessWidget {
  final ulkeAdi;
  final SiralamaAciklama;
  ulkeSiralamaAciklama({this.ulkeAdi,this.SiralamaAciklama});

  @override
  Widget build(BuildContext context) {
    return Text(
      ulkeAdi + SiralamaAciklama,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );
  }
}

