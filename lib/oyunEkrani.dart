import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'zamanButonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'anasayfa.dart';
import 'insaat.dart';
import 'İnsaatWidgetlari.dart';
import 'atolye.dart';

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
  final Box settingsBox = Hive.box("settings");
  ValueNotifier<int> population = ValueNotifier<int>(100000);
  int soldier = 1000;
  int police = 2500;
  int terrorist = 1000;
  double terror_rate = 2;
  double birth_rate = 10;
  double death_rate = 8;
  int money = 0;
  DateTime ayNoktasi = DateTime.now();
  int factoryNum = 0;
  int tax = 10;
  int school = 0;
  DateTime date = DateTime.now();

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  monthlyChanges() {
    double increase = 0.02;

    increase = increase - terrorist ~/ 1000 * 0.2;
    if (tax == 10) {
      population.value = population.value + (population.value * increase).toInt();
    } else if (tax == 20) {
      increase = increase - 0.2;
      population.value = population.value + (population.value * increase).toInt();
    } else {
      increase = increase + 0.1;
      population.value = population.value + (population.value * increase).toInt();
    }
    if (school < 1450) terrorist = terrorist + population.value ~/ 100;
    money = money + (factoryNum * 100000) - (police * 1000) - (soldier * 1000);
    dataBox.put("para", money);
  }

  getDate() {
    if (dataBox.containsKey("date") && dataBox.get("date") != null) {
      date = dataBox.get("date");
      print(date);
    }
    if (dataBox.containsKey("ayNoktasi") && dataBox.get("ayNoktasi") != null) {
      ayNoktasi = dataBox.get("ayNoktasi");
      print(ayNoktasi);
    } else {
      dataBox.put("ayNoktasi", DateTime.now());
    }
  }

  dailyChanges() {
    money = money + tax * population.value;
    dataBox.put("para", money);
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

    setState(() {});
    return dataBox.get("date");
  }

  yapiKontrol(int maliyet, String yapi, int? max) {
    int para = dataBox.get("para");
    if (para >= maliyet) {
      if (max == null) {
        int yapiSayisi = dataBox.get(yapi) + 1;
        dataBox.put(yapi, yapiSayisi);
      } else {
        if (dataBox.get(yapi) < max) {
          int yapiSayisi = dataBox.get("atolye") + 1;
          dataBox.put(yapi, yapiSayisi);
        } else {
          Fluttertoast.showToast(msg: "Maximum $yapi inşaa ettiniz.");
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Yeterli paranız bulunmamaktadır.");
    }
  }

  yapiInsaEt(String yapi) {
    switch (yapi) {
      case "atolye":
        yapiKontrol(3000000, yapi, 400);
        break;
      case "ciftlik":
        yapiKontrol(6000000, yapi, 400);
        break;
      case "liman":
        yapiKontrol(15000000000, yapi, 1);
        break;
      case "kisla":
        yapiKontrol(3000000, yapi, null);
        break;
      case "tapinak":
        yapiKontrol(1500000, yapi, null);
        break;
      case "hastane":
        yapiKontrol(30000000, yapi, 90);
        break;
      case "manastir":
        yapiKontrol(1000000, yapi, 1450);
        break;
      default:
    }
    if (money >= 1000000) {
      school = dataBox.get("schoolNum") + 1;
      dataBox.put("schoolNum", school);
    } else {
      Fluttertoast.showToast(msg: "Yeterli paranız yok");
    }
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

  final oneSec = Duration(seconds: 28);
  Future dateTimer() async {
    Timer.periodic(
      oneSec,
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
      body: Row(
        children: [
          Expanded(
            flex: 2,
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
                    ValueListenableBuilder<int>(
                      valueListenable: population,
                      builder: (BuildContext context, dynamic value, Widget? child) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Nüfus: " + population.value.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: dateStream,
                      builder: (context, snaphot) {
                        print(snaphot.data);
                        return Container(
                          child: Text(
                            "Day : " + date.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: ValueNotifier<int>(dataBox.get("para")),
                        builder: (context, value, _) {
                          return Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          );
                        }),
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
                          sayfaCagirma: Insaat(),
                          sayfaIsmi: 'İnsaat',
                        ),
                        YanButton(
                          sayfaCagirma: sirketler(),
                          sayfaIsmi: 'Mağaza',
                        ),
                        YanButton(
                          sayfaCagirma: sirketler(),
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
      ),
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
