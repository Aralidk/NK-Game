import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:nkmanagetheworld/Widgetlar.dart';
import 'package:nkmanagetheworld/oyunEkrani.dart';

class VergiSistemi extends StatefulWidget {
  @override
  State<VergiSistemi> createState() => _VergiSistemiState();
}

class _VergiSistemiState extends State<VergiSistemi> {
  Box dataBox = Hive.box("data");
  int tax = 10;
  double increase = 0.02;
/*
  vergiHesaplama(tax) {
    int nufus = dataBox.get("nufus");
    if (tax == 10) {
      nufus = nufus + (nufus * increase).toInt();
      print("1");
    } else if (tax == 20) {
      increase = increase - 0.2;
      nufus = nufus + (nufus * increase).toInt();
      dataBox.put("nufus", nufus);
      print("2");
    } else if (tax == 30) {
      increase = increase - 0.3;
      nufus = nufus + (nufus * increase).toInt();
    } else if (tax == 40) {
      increase = increase - 0.4;
      nufus = nufus + (nufus * increase).toInt();
    } else if (tax == 50) {
      increase = increase - 0.5;
      nufus = nufus + (nufus * increase).toInt();
    } else {
      increase = increase + 0.1;
      nufus = nufus + (nufus * increase).toInt();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x476E87CB),
        body: HiveListener<dynamic>(
          keys: ["tax"],
          box: dataBox,
          builder: (box) {
            return Container(
              child: RotatedBox(
                quarterTurns: 5,
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        direction: Axis.vertical,
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          vergiBilgilendirme(
                            vergiAciklama:
                                "Halktan vergi alma. (Nüfusu %10 artırır.)",
                            SecilenVergi: 0,
                          ),
                          vergiBilgilendirme(
                            vergiAciklama:
                                " Günlük 10 birim vergi al. (İdeal vergi miktarıdır. Pozitif veya negatif etkisi yoktur.)",
                            SecilenVergi: 10,
                          ),
                          vergiBilgilendirme(
                            vergiAciklama:
                                " Günlük 20 birim vergi al. ( Nüfus %20 küçülür.)",
                            SecilenVergi: 20,
                          ),
                          vergiBilgilendirme(
                            vergiAciklama:
                                "Günlük 30 birim vergi al. (Nüfus %30 küçülür.)",
                            SecilenVergi: 30,
                          ),
                          vergiBilgilendirme(
                            vergiAciklama:
                                "Günlük 40 birim vergi al. (Nüfus %40 küçülür.)",
                            SecilenVergi: 40,
                          ),
                          vergiBilgilendirme(
                            vergiAciklama:
                                "Günlük 50 birim vergi al. (Nüfus %50 küçülür.)",
                            SecilenVergi: 50,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Card(
                                color: Colors.transparent,
                                child: GeriButonu((OyunEkrani()))
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class vergiBilgilendirme extends StatelessWidget {
  final vergiAciklama;
  final SecilenVergi;
  vergiBilgilendirme({
    this.vergiAciklama,
    this.SecilenVergi,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
        width: screenSize.width / 2,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/vergiButon.png",)
          )
        ),
        child: InkWell(
            onTap: () =>
                {vergiHesaplama(SecilenVergi), showAlertDialog(context)},
            child: Ink(
              padding: EdgeInsets.symmetric(vertical: 20),
                height: screenSize.height / 6,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text(vergiAciklama,
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            )));
  }

  vergiHesaplama(tax) {
    Box dataBox = Hive.box("data");
    double increase = 0.02;
    int nufus = dataBox.get("nufus");

    if (tax == 10) {
      nufus = nufus + (nufus * increase).toInt();
      print("1");
    } else if (tax == 20) {
      increase = increase - 0.2;
      nufus = nufus + (nufus * increase).toInt();
      dataBox.put("nufus", nufus);
      print("2");
    } else if (tax == 30) {
      increase = increase - 0.3;
      nufus = nufus + (nufus * increase).toInt();
    } else if (tax == 40) {
      increase = increase - 0.4;
      nufus = nufus + (nufus * increase).toInt();
    } else if (tax == 50) {
      increase = increase - 0.5;
      nufus = nufus + (nufus * increase).toInt();
    } else {
      increase = increase + 0.1;
      nufus = nufus + (nufus * increase).toInt();
    }
  }
}

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return RotatedBox(
            quarterTurns: 5,
            child: AlertDialog(
              backgroundColor: Color(0xC7855914),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Tamam",
                    style: TextStyle(color: Color(0xFFEFBB8B)),
                  ),
                ),
              ],
              content: Container(
                height: 100,
                child: Text(
                  "Vergi sistemi değiştirildi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ));
      });
}
