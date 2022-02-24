import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class YapiController {
  final dataBox = Hive.box("data");
  atolyeGetiri() {
    int getiri = dataBox.get("atolye")["adet"] * 3000000;
    dataBox.put("para", dataBox.get("para") + getiri);
  }

  ciftlikGetiri() {
    int getiri = dataBox.get("ciftlik")["adet"] * 400000;
    dataBox.put("para", dataBox.get("para") + getiri);
  }

  kislaGetiri() {
    int getiri = dataBox.get("kisla")["adet"] * 100;
    dataBox.put("sipahi", dataBox.get("sipahi") + getiri);
  }

  tapinakGetiri() {
    int getiri = dataBox.get("tapinak")["adet"] * 100;
    dataBox.put("sovalye", dataBox.get("sovalye") + getiri);
  }

  hastaneGetiri() {
    int hastaneSayisi = dataBox.get("hastane")["adet"];
    double olumOrani = dataBox.get("olum_oran");
    if (hastaneSayisi >= 10 && hastaneSayisi < 40) {
      olumOrani = olumOrani - 0.01;
      dataBox.put("olum_oran", olumOrani);
    } else if (hastaneSayisi >= 40 && hastaneSayisi < 90) {
      olumOrani = olumOrani - 0.02;
      dataBox.put("olum_oran", olumOrani);
    } else if (hastaneSayisi >= 90) {
      olumOrani = olumOrani - 0.03;
      dataBox.put("olum_oran", olumOrani);
    }
  }

  manastirSayisiGetiri() {
    int manastirSayisi = dataBox.get("manastirSayisi")["adet"];
    double isyanciDonusum = dataBox.get("isyanci_oran");
    if (manastirSayisi >= 10 && manastirSayisi < 20) {
      isyanciDonusum = isyanciDonusum - 0.001;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 30 && manastirSayisi < 60) {
      isyanciDonusum = isyanciDonusum - 0.002;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 60 && manastirSayisi < 110) {
      isyanciDonusum = isyanciDonusum - 0.003;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 110 && manastirSayisi < 180) {
      isyanciDonusum = isyanciDonusum - 0.004;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 180 && manastirSayisi < 300) {
      isyanciDonusum = isyanciDonusum - 0.005;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 300 && manastirSayisi < 450) {
      isyanciDonusum = isyanciDonusum - 0.006;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 450 && manastirSayisi < 650) {
      isyanciDonusum = isyanciDonusum - 0.007;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 650 && manastirSayisi < 900) {
      isyanciDonusum = isyanciDonusum - 0.008;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 900 && manastirSayisi < 1450) {
      isyanciDonusum = isyanciDonusum - 0.009;
      dataBox.put("isyanci_oran", isyanciDonusum);
    } else if (manastirSayisi >= 1450) {
      isyanciDonusum = isyanciDonusum - 0.01;
      dataBox.put("isyanci_oran", isyanciDonusum);
    }
  }

  getiriKontrol(String yapi) {
    switch (yapi) {
      case "atolye":
        atolyeGetiri();
        break;
      case "ciftlik":
        ciftlikGetiri();
        break;
      // case "liman":
      //   kislaGetiri(15000000000, yapi, 1);
      //   break;
      case "kisla":
        kislaGetiri();
        break;
      case "tapinak":
        tapinakGetiri();
        break;
      case "hastane":
        hastaneGetiri();
        break;
      case "manastirSayisi":
        manastirSayisiGetiri();
        break;
      default:
    }
  }

  yapiInsaEt(Map yapi) {
    print(dataBox.get("para"));
    if (dataBox.get("para") >= dataBox.get(yapi.keys.first)["maliyet"]) {
      if (dataBox.get(yapi.keys.first)["max"] == 0) {
        int yapiSayisi = dataBox.get(yapi.keys.first)["adet"] + 1;
        Map yapiMap = dataBox.get(yapi.keys.first);
        yapiMap["adet"] = yapiSayisi;
        dataBox.put(yapi.keys.first, yapiMap);
        dataBox.put("para", dataBox.get("para") - dataBox.get(yapi.keys.first)["maliyet"]);
      } else {
        if (dataBox.get(yapi.keys.first)["adet"] < dataBox.get(yapi.keys.first)["max"]) {
          int yapiSayisi = dataBox.get(yapi.keys.first)["adet"] + 1;
          Map yapiMap = dataBox.get(yapi.keys.first);
          yapiMap["adet"] = yapiSayisi;
          dataBox.put(yapi.keys.first, yapiMap);
          dataBox.put("para", dataBox.get("para") - dataBox.get(yapi.keys.first)["maliyet"]);
        } else {
          Fluttertoast.showToast(msg: "Maximum ${yapi.values.first} inşaa ettiniz.");
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Yeterli paranız bulunmamaktadır.");
    }
    print(dataBox.get(yapi.keys.first));
  }
  showYapiAlert(Map yapi, BuildContext context) {
    print(dataBox.get(yapi.keys.first));
    print("dataBox.get(yapi)");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RotatedBox(quarterTurns: 5,
        child: AlertDialog(
          backgroundColor: Color(0xC7855914),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 200,
            child: Column(
              children: [
                Text(yapi.values.first + " inşaa edecekseniz emin misiniz ?",
                style: TextStyle(
                  color: Colors.white
                ),),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Hayır",
                        style: TextStyle(
                            color: Color(0xFFEFBB8B)
                        ),),
                    ),
                    TextButton(
                      onPressed: () {
                        yapiInsaEt(yapi);
                        Navigator.pop(context);
                      },
                      child: Text("Evet",
                      style: TextStyle(
                        color: Color(0xFFF3C195)
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  
}
