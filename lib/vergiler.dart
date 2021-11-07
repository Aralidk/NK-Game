import 'package:flutter/widgets.dart';
import 'package:nkmanagetheworld/Widgetlar.dart';
import 'oyunEkrani.dart';
import 'package:flutter/material.dart';

class vergiSistemi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 600,
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
    return RaisedButton(
      color: Color(0x476E87CB),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.only(top: 15),
        height: 100,
        width: 200,
        //color: Color(0xFFF8CDA6),
        child: Text(
          vergiAciklama,
          style: TextStyle(
            color: Color(0xFFF3C195),
            fontSize: 15,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
