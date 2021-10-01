import 'anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  Map entries = {
    "factoryNum":0,
    "monthPoint":DateTime.now(),
    "date":DateTime.now(),
    "schoolNum":0,
    "money":100000,
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('game');
  await Hive.openBox("data");
  await Hive.openBox("settings");
  await Hive.box("data").putAll(entries);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: anasayfa(),
    );
  }
}
