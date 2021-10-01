import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'fonksiyonlar.dart';
import 'package:flutter/material.dart';




class textButonu extends StatelessWidget {
  int school = 0;
  final Box dataBox = Hive.box("data");
  final Box settingsBox = Hive.box("settings");

  final altYazi;
  final aciklama;
  textButonu(this.aciklama,this.altYazi);

  get money => HomePage();
  get box => HomePage();
  buildSchool() {
    if (money >= 1000000) {
      school = dataBox.get("schoolNum") + 1;
      dataBox.put("schoolNum", school);
    } else {
      Fluttertoast.showToast(msg: "Yeterli paranız yok");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                box.put("schoolNum", school);
              },
              child: Icon(Icons.add),
            ),
          ]),
        ),
      ),
      child: Text(altYazi,
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

class geriButonu extends StatelessWidget {
  final geriButonuAdresi;
  geriButonu(this.geriButonuAdresi);
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      color: Color(0x476E87CB),
      child: IconButton(onPressed:(){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => geriButonuAdresi));
      },
        alignment: Alignment.center,
        icon: Icon(Icons.exit_to_app_outlined), color: Colors.red,
      ),
    );
  }
}




