import 'anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  Map entries = {
    "fabrikaSayisi": 1,
    "date": DateTime.now(),
    "baslangic": DateTime.now(),
    "ayNoktasi": DateTime.now(),
    "yapiSayisi": 0,
    "para": 5000000,
    "atolye": {"adet": 1, "maliyet": 3000000, "max": 400},
    "ciftlik": {"adet": 1, "maliyet": 6000000, "max": 400},
    "liman": {"adet": 1, "maliyet": 15000000000, "max": 1},
    "kisla": {"adet": 1, "maliyet": 3000000, "max": 0},
    "tapinak": {"adet": 1, "maliyet": 1500000, "max": 0},
    "hastane": {"adet": 1, "maliyet": 30000000, "max": 90},
    "manastir": {"adet": 1, "maliyet": 1000000, "max": 1450},
    "aktif_sipahi": 1000,
    "aktif_sovalye": 2500,
    "sipahi": 0,
    "sovalye": 0,
    "isyanci": 1000,
    "nufus":100000,
    "isyanci_oran": 1,
    "sipahi_maas": 1000,
    "dogum_oran": 0.1,
    "olum_oran": 0.08,
    "sovalye_maas": 1000,
    "kumas_alim":50,
    "yiyecek_alim":35,
    "ilac_alim":65,
    "ilac_sirket":{"maliyet":170000000000,"adet":0,"max":1},
    "kumas_sirket":{"maliyet":50000000000,"adet":0,"max":1},
    "gida_sirket":{"maliyet":30000000000,"adet":0,"max":1},
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('game');
  await Hive.openBox("data");
  await Hive.openBox("settings");
  entries.keys.forEach((element) async {
    if (!Hive.box("data").containsKey(element)) await Hive.box("data").put(element, entries[element]);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}
