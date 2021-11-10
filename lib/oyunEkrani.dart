import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:intl/intl.dart';
import 'package:nkmanagetheworld/controller/yapi_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:nkmanagetheworld/vergiler.dart';
import 'anasayfa.dart';
import 'insaat.dart';
import 'Widgetlar.dart';
import 'sıralama.dart';

class OyunEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
    ]);
    final screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Harita(screenSize),
    );
  }
}

class Harita extends StatefulWidget {
  Harita(Size screenSize);

  @override
  State<Harita> createState() => _HaritaState();
}

class _HaritaState extends State<Harita> {
  final Box dataBox = Hive.box("data");
  final yapiCntrl = YapiController();
  final Box settingsBox = Hive.box("settings");
  DateTime ayNoktasi = DateTime.now();
  int factoryNum = 0;
  int tax = 10;
  DateTime date = DateTime.now();

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  nufusHesapla() {
    int nufus = dataBox.get("nufus");
    int isyanci = dataBox.get("isyanci");
    double degisimOran = dataBox.get("dogum_oran") - dataBox.get("olum_oran");
    degisimOran = degisimOran - ((isyanci ~/ 1000) * 0.002);
    if (tax == 10) {
      nufus = nufus + (nufus * degisimOran).toInt();
      dataBox.put("nufus", nufus);
    } else if (tax == 20) {
      degisimOran = degisimOran - 0.2;
      nufus = nufus + (nufus * degisimOran).toInt();
      dataBox.put("nufus", nufus);
    } else if (tax == 0) {
      degisimOran = degisimOran + 0.1;
      nufus = nufus + (nufus * degisimOran).toInt();
      dataBox.put("nufus", nufus);
    }
    if (dataBox.get("manastir")["adet"] < 1450) isyanci = isyanci + nufus ~/ 100;
  }

  monthlyChanges() {
    double satinAlimlar =
        (dataBox.get("ilac_alim") + dataBox.get("kumas_alim") + dataBox.get("yiyecek_alim")) * dataBox.get("nufus");
    List yapilar = [
      "atolye",
      "hastane",
      "kisla",
      "liman",
      "manastir",
      "tapinak",
      "ciftlik",
    ];
    for (String yapi in yapilar) {
      yapiCntrl.getiriKontrol(yapi);
    }
    dataBox.put("para", dataBox.get("para") - satinAlimlar);
    nufusHesapla();
  }

  getDate() {
    if (dataBox.containsKey("date") && dataBox.get("date") != null) {
      date = dataBox.get("date");
    }
    if (dataBox.containsKey("ayNoktasi") && dataBox.get("ayNoktasi") != null) {
      ayNoktasi = dataBox.get("ayNoktasi");
    } else {
      dataBox.put("ayNoktasi", DateTime.now());
    }
  }

  dailyChanges() {
    dataBox.put("para", dataBox.get("para") + tax * dataBox.get("nufus"));
  }

  Future<DateTime> setDate() async {
    getDate();
    date = date.add(Duration(days: 1));
    dataBox.put("date", date);

    if (daysBetween(dataBox.get("ayNoktasi"), dataBox.get("date")) == 30) {
      monthlyChanges();
      dataBox.put("ayNoktasi", dataBox.get("date"));
    } else {
      dailyChanges();
    }
    return dataBox.get("date");
  }

  buildFactory() {
    if (factoryNum < 400) {
      if (dataBox.get("money") >= 1000000) {
        factoryNum = dataBox.get("factoryNum") + 1;
        dataBox.put("factoryNum", factoryNum);
      } else {
        Fluttertoast.showToast(msg: "Yeterli paranız yok");
      }
    } else {
      Fluttertoast.showToast(msg: "Maksimum sayıda fabrika inşaa edildi.");
    }
  }

  Future dateTimer() async {
    setState(() {});
    print(DateTime.now());
    Timer.periodic(
      Duration(seconds: 28),
      (Timer t) {
        setDate();
        t.cancel();
      },
    );
    return dataBox.get("date");
  }

  @override
  Widget build(BuildContext context) {
    Stream dateStream = Stream.fromFuture(dateTimer());
    return Scaffold(
      backgroundColor: Color(0),
      body: HiveListener<dynamic>(
          keys: ["nufus", "date", "para"],
          box: dataBox,
          builder: (box) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0x476E87CB),
                    child: RotatedBox(
                      quarterTurns: 5,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            AltAciklama(
                              aciklanan: "Nüfus: " + box.get("nufus").toString(),
                            ),
                            AltAciklama(
                              aciklanan: "Kasa: " + dataBox.get("para").toString(),
                            ),
                            AltAciklama(
                              aciklanan: "Asker: " + box.get("aktif_sipahi").toString(),
                            ),
                            AltAciklama(
                              aciklanan: "Muhafız: " + box.get("aktif_sovalye").toString(),
                            ),
                            AltAciklama(
                              aciklanan: "İsyancı: " + box.get("isyanci").toString(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                askerAlimButonu(),
                                GeriButonu(
                                  AnaSayfa(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/harita.png",
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 5, right: 5),
                          color: Color(0x476E87CB),
                          child: RotatedBox(
                            quarterTurns: 5,
                            child: Wrap(alignment: WrapAlignment.center, runSpacing: 5, spacing: 10, children: [
                              Container(
                                child: StreamBuilder(
                                  stream: dateStream,
                                  builder: (context, snaphot) {
                                    return Text(
                                      "Day : " + DateFormat('yMd').format(box.get("date")),
                                      style: TextStyle(color: Color(0xFFF3C195), fontSize: 20),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  zamanButon(
                                    Icon(Icons.pause_circle_outline),
                                  ),
                                  zamanButon(
                                    Icon(Icons.play_circle_outline_outlined),
                                  ),
                                  zamanButon(
                                    Icon(Icons.reply_all_outlined),
                                  ),
                                ],
                              ),
                              YanButton(
                                sayfaCagirma: Insaat(
                                  nerden: 'yapi',
                                ),
                                sayfaIsmi: 'İnsaat',
                              ),
                              YanButton(
                                sayfaCagirma: Insaat(
                                  nerden: 'sirket',
                                ),
                                sayfaIsmi: 'Mağaza',
                              ),
                              YanButton(
                                sayfaCagirma: Insaat(
                                  nerden: 'sirket',
                                ),
                                sayfaIsmi: 'Şirketler',
                              ),
                              YanButton(
                                sayfaCagirma: Siralama(),
                                sayfaIsmi: 'Sıralamalar',
                              ),
                              YanButton(
                                sayfaCagirma: VergiSistemi(),
                                sayfaIsmi: 'Vergi',
                              ),
                              YanButton(
                                sayfaCagirma: AnaSayfa(),
                                sayfaIsmi: 'Etkiler',
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class YanButton extends StatelessWidget {
  final sayfaCagirma;
  final sayfaIsmi;
  YanButton({required this.sayfaCagirma, required this.sayfaIsmi});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: 110,
          height: 55,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/buton.png",
              ),
            ),
          ),
          child: Text(sayfaIsmi,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => sayfaCagirma));
        });
  }
}

class AltAciklama extends StatelessWidget {
  final aciklanan;
  AltAciklama({this.aciklanan});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/altButonlar.png",
          ),
        ),
      ),
      child: Text(aciklanan, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}
