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
    "para": 500000,
    "atolye": 1,
    "ciftlik": 1,
    "liman": 1,
    "kisla": 1,
    "tapinak": 1,
    "hastane": 1,
    "manastir": 1,
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
