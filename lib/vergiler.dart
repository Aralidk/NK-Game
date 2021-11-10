import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nkmanagetheworld/Widgetlar.dart';
import 'package:nkmanagetheworld/anasayfa.dart';
import 'package:nkmanagetheworld/oyunEkrani.dart';

class vergiSistemi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0x476E87CB),
        child: RotatedBox(
          quarterTurns: 5,
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    vergiBilgilendirme(
                      vergiAciklama: "Halktan vergi alma. (Nüfusu %10 artırır.)",
                    ),
                    vergiBilgilendirme(
                      vergiAciklama:
                          " Günlük 10 birim vergi al. (İdeal vergi miktarıdır. Pozitif veya negatif etkisi yoktur.)",
                    ),
                    vergiBilgilendirme(
                        vergiAciklama:
                            " Günlük 20 birim vergi al. ( Nüfus %20 küçülür.)"),
                    vergiBilgilendirme(
                      vergiAciklama:
                          "Günlük 30 birim vergi al. (Nüfus %30 küçülür.)",
                    ),
                    vergiBilgilendirme(
                      vergiAciklama:
                          "Günlük 40 birim vergi al. (Nüfus %40 küçülür.)",
                    ),
                    vergiBilgilendirme(
                      vergiAciklama:
                          "Günlük 50 birim vergi al. (Nüfus %50 küçülür.)",
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Card(
                        color: Colors.transparent,
                          child: GeriButonu((OyunEkrani()))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class vergiBilgilendirme extends StatelessWidget {
  final vergiAciklama;
  vergiBilgilendirme({this.vergiAciklama});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.only(top: 15),
          height: 100,
          width: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/vergiButon.png",
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 70, right: 60),
            alignment: Alignment.center,
            child: Text(
              vergiAciklama,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ));
  }
}
