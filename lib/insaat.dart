import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:nkmanagetheworld/controller/yapi_controller.dart';

import 'oyunEkrani.dart';
import 'İnsaatWidgetlari.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Insaat extends StatelessWidget {
  final String nerden;
  const Insaat({Key? key, required this.nerden}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List yapilar;
    nerden == "yapi"
        ? yapilar = [
            {"atolye": "Atolye"},
            {"hastane": "Hastane"},
            {"kisla": "Kışla"},
            {"liman": "Liman"},
            {"manastir": "Manastır"},
            {"tapinak": "Tapınak"},
            {"ciftlik": "Çiftlik"},
          ]
        : yapilar = [
            {"ilac_sirketi": "İlaç Şirketi"},
            {"kumas_sirketi": "Kumaş Şirketi"},
            {"gida_sirketi": "Yiyecek İçecek Şirketi"}
          ];
    final yapiCntrl = YapiController();
    print(yapilar.length);
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
                      for (Map yapi in yapilar)
                        Column(
                          children: [
                            Text(
                              yapi.values.first,
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                yapiCntrl.showYapiAlert(yapi, context);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/${yapi.keys.first}.png"),
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
