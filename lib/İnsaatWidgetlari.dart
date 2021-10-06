import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'fonksiyonlar.dart';
import 'package:flutter/material.dart';

class TextButonu extends StatelessWidget {
  final altYazi;
  final aciklama;
  const TextButonu(this.aciklama, this.altYazi);

  @override
  Widget build(BuildContext context) {
    int school = 0;
    final Box dataBox = Hive.box("data");
    final Box settingsBox = Hive.box("settings");
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => RotatedBox(
          quarterTurns: 5,
          child: AlertDialog(content: Text(aciklama), actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Kapat'),
              child: const Text('Kapat'),
            ),
            ElevatedButton(
              onPressed: () {
                school = school + 1;
              },
              child: Icon(Icons.add),
            ),
          ]),
        ),
      ),
      child: Text(
        altYazi,
        style: TextStyle(
          color: Color(0xFFC21616),
        ),
      ),
    );
  }
}

class resimKutulari extends StatelessWidget {
  final resim;
  resimKutulari({this.resim});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Image.asset(resim),
    );
  }
}

class GeriButonu extends StatelessWidget {
  final geriButonuAdresi;
  GeriButonu(this.geriButonuAdresi);
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0x476E87CB),
      child: IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => geriButonuAdresi));
        },
        alignment: Alignment.center,
        icon: Icon(Icons.exit_to_app_outlined),
        color: Colors.red,
      ),
    );
  }
}
