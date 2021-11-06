import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:intl/intl.dart';
import 'package:nkmanagetheworld/controller/yapi_controller.dart';
import 'Widgetlar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'anasayfa.dart';
import 'insaat.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    dataBox.put("eski_para", dataBox.get("para"));
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
    dataBox.put("eski_para", dataBox.get("para"));
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
      if (dataBox.get("para") >= 1000000) {
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
    return HiveListener<dynamic>(
        box: dataBox,
        builder: (box) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: Container(
              width: MediaQuery.of(context).size.width / 2 + 10,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 56),
                  AltButton(
                    information: box.get("nufus").toString(),
                    text: "Nüfus:",
                    statics: (box.get("dogum_oran") - box.get("olum_oran")),
                    altButonSayfa: AnaSayfa(),
                  ),
                  AltButton(
                    information: box.get("aktif_sipahi").toString(),
                    altButonSayfa: AnaSayfa(),
                    text: "Sipahi:",
                    statics: (box.get("kisla")["adet"] * 100),
                  ),
                  AltButton(
                    information: box.get("aktif_sovalye").toString(),
                    altButonSayfa: AnaSayfa(),
                    text: "Şövalye:",
                    statics: (box.get("tapinak")["adet"] * 100),
                  ),
                  AltButton(
                    information: box.get("isyanci").toString(),
                    altButonSayfa: AnaSayfa(),
                    text: "İsyancı:",
                    statics: box.get("isyanci_oran") * box.get("isyanci") * 0.01,
                  ),
                  AltButton(
                    information: box.get("para").toString(),
                    altButonSayfa: AnaSayfa(),
                    text: "Para:",
                    statics: (box.get("para") - box.get("eski_para")),
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0),
            body: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.75,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/harita.png"), fit: BoxFit.fill),
                            ),
                          ),
                          /*RotatedBox(quarterTurns: 5,
                                child: Column(
                                  children: [
                                    /*Container(
                                      child: Text(
                                        "Nüfus: " + box.get("nufus").toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    ),*/
                                    /*Text(
                                      dataBox.get("para").toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),*/
                                  ],
                                ),
                              ),*/
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 5, right: 5),
                              color: Color(0x476E87CB),
                              child: RotatedBox(
                                quarterTurns: 5,
                                child: Wrap(
                                  runSpacing: 5,
                                  spacing: 10,
                                  children: [
                                    StreamBuilder(
                                      stream: dateStream,
                                      builder: (context, snaphot) {
                                        return Text(
                                          "Day : " + DateFormat('yMd').format(box.get("date")),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(color: Color(0xFFC21616), fontSize: 20),
                                        );
                                      },
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      zamanButon(
                                        Icon(Icons.pause_circle_outline),
                                      ),
                                      zamanButon(
                                        Icon(Icons.play_circle_outline_outlined),
                                      ),
                                      zamanButon(
                                        Icon(Icons.reply_all_outlined),
                                      ),
                                    ]),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 1,
                  child: RotatedBox(
                    quarterTurns: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class AltButton extends StatelessWidget {
  final String text;
  final String information;
  final statics;
  final altButonSayfa;
  AltButton({required this.text, required this.altButonSayfa, required this.information, required this.statics});
  @override
  Widget build(BuildContext context) {
    print(statics.runtimeType);
    print(statics);
    return Container(
      width: MediaQuery.of(context).size.width/2,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Spacer(),
          Text(
            information,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Icon(
            statics == 0
                ? Icons.remove
                : statics > 0 
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
            color: statics == 0
                ? Colors.grey
                : statics < 0
                    ? Colors.red
                    : Colors.green, 
          ),
          Text(
            statics.runtimeType == double ? statics.toStringAsFixed(2) : statics.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: statics == 0
                  ? Colors.grey
                  : statics < 0
                      ? Colors.red
                      : Colors.green,
            ),
          ),
        ],
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
          child: Text(sayfaIsmi, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => sayfaCagirma));
        });
  }
}
