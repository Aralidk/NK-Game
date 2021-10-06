import 'dart:ui';
import 'oyunEkrani.dart';
import 'İnsaatWidgetlari.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Insaat extends StatefulWidget {
  @override
  _InsaatState createState() => _InsaatState();
}

class _InsaatState extends State<Insaat> {
  List yapilar = [
    "atolye",
    "hastane",
    "kisla",
    "liman",
    "manastir",
    "tapinak",
    "ciftlik",
  ];

  showYapiAlert(String yapi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 200,
            child: RotatedBox(
              quarterTurns: 5,
              child: Column(
                children: [
                  Text(yapi + "inşaa edecekseniz emin misiniz ?"),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Hayır"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Evet"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0),
      body: Center(
        child: Container(
          width: 325,
          height: 600,
          color: Color(0x476E87CB),
          child: RotatedBox(
            quarterTurns: 5,
            child: Row(
              children: [
                GeriButonu(OyunEkrani()),
                Expanded(
                  child: Wrap(
                    children: [
                      for (String yapi in yapilar)
                        Column(
                          children: [
                            Text(
                              yapi,
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                showYapiAlert(yapi);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/$yapi.png"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
