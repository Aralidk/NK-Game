import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:intl/intl.dart';
import 'package:nkmanagetheworld/controller/yapi_controller.dart';
import 'zamanButonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'anasayfa.dart';
import 'insaat.dart';
import 'İnsaatWidgetlari.dart';

class OyunEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Harita(),
    );
  }
}

class Harita extends StatefulWidget {
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
                  flex: 3,
                  child: Container(
                    color: Color(0x476E87CB),
                    child: RotatedBox(
                      quarterTurns: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              AltButton(
                                text: 'Nüfus',
                              ),
                              AltButton(
                                text: 'Asker Sayısı',
                              ),
                              AltButton(
                                text: 'Muhafız Sayısı',
                              ),
                              AltButton(
                                text: 'İsyancı Sayısı',
                              ),
                              AltButton(
                                text: 'Kasa',
                              ),
                              GeriButonu(
                                AnaSayfa(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/yeni_harita.png",
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Nüfus: " + box.get("nufus").toString(),
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          StreamBuilder(
                            stream: dateStream,
                            builder: (context, snaphot) {
                              return Container(
                                child: Text(
                                  "Day : " + DateFormat('yMd').format(box.get("date")),
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              );
                            },
                          ),
                          Text(
                            dataBox.get("para").toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
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
                                Icon(Icons.pause_circle_outline),
                              ),
                              zamanButon(
                                Icon(Icons.play_circle_outline_outlined),
                              ),
                              zamanButon(
                                Icon(Icons.reply_all_outlined),
                              ),
                              YanButton(
                                sayfaCagirma: Insaat(nerden: 'yapi',),
                                sayfaIsmi: 'İnsaat',
                              ),
                              YanButton(
                                sayfaCagirma: Insaat(nerden: 'sirket',),
                                sayfaIsmi: 'Mağaza',
                              ),
                              YanButton(
                                sayfaCagirma:Insaat(nerden: 'sirket',),
                                sayfaIsmi: 'Şirketler',
                              ),
                              YanButton(
                                sayfaCagirma: AnaSayfa(),
                                sayfaIsmi: 'Sıralamalar',
                              ),
                              YanButton(
                                sayfaCagirma: AnaSayfa(),
                                sayfaIsmi: 'Vergi',
                              ),
                              YanButton(
                                sayfaCagirma: AnaSayfa(),
                                sayfaIsmi: 'Etkiler',
                              ),
                            ],
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

class AltButton extends StatelessWidget {
  final text;
  AltButton({required this.text});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Color(0xFFC21616),
        ),
        foregroundColor: MaterialStateProperty.all(
          const Color(0xFF000000),
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class YanButton extends StatelessWidget {
  final sayfaCagirma;
  final sayfaIsmi;
  YanButton({required this.sayfaCagirma, required this.sayfaIsmi});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFFC21616)),
          foregroundColor: MaterialStateProperty.all(
            const Color(0xFF000000),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ),
        child: Text(sayfaIsmi, style: TextStyle(fontSize: 16)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => sayfaCagirma));
        });
  }
}
