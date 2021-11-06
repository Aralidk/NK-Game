import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



class Functions{
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  final Box dataBox = Hive.box("data");
  final Box settingsBox = Hive.box("settings");
  ValueNotifier<int> population = ValueNotifier<int>(100000);
  int soldier = 1000;
  int police = 2500;
  int terrorist = 1000;
  double terror_rate = 2;
  double birth_rate = 10;
  double death_rate = 8;
  DateTime monthPoint = DateTime.now();
  int money = 0;
  int factoryNum = 0;
  int tax = 10;
  int school = 0;
  DateTime date = DateTime.now();
  // getDate() {
  //   if (dataBox.containsKey("date") && dataBox.get("date") != null) {
  //     date = dataBox.get("date");
  //     print(date);
  //   }
  //   if (dataBox.containsKey("monthPoint") && dataBox.get("monthPoint") != null) {
  //     monthPoint = dataBox.get("monthPoint");
  //     print(monthPoint);
  //   } else {
  //     dataBox.put("monthPoint", DateTime.now());
  //   }
  // }

  // Future<DateTime> setDate() async {
  //   getDate();
  //   date = date.add(Duration(days: 1));
  //   dataBox.put("date", date);

  //   if (daysBetween(dataBox.get("monthPoint"), dataBox.get("date")) == 30) {
  //     monthlyChanges();
  //     dataBox.put("monthPoint", dataBox.get("date"));
  //   } else {
  //     dailyChanges();
  //   }

  //   setState(() {});
  //   return dataBox.get("date");
  // }

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
    dataBox.put("money", money);
  }

  setTerroristNum() {
    if (school <= 10) {
      terrorist = terrorist - (terrorist * 0.001).toInt();
    } else if (school <= 20) {
      terrorist = terrorist - (terrorist * 0.002).toInt();
    } else if (school <= 30) {
      terrorist = terrorist - (terrorist * 0.003).toInt();
    } else if (school <= 50) {
      terrorist = terrorist - (terrorist * 0.004).toInt();
    } else if (school <= 70) {
      terrorist = terrorist - (terrorist * 0.005).toInt();
    } else if (school <= 120) {
      terrorist = terrorist - (terrorist * 0.006).toInt();
    } else if (school <= 150) {
      terrorist = terrorist - (terrorist * 0.007).toInt();
    } else if (school <= 200) {
      terrorist = terrorist - (terrorist * 0.008).toInt();
    } else if (school <= 250) {
      terrorist = terrorist - (terrorist * 0.009).toInt();
    } else if (school <= 550) {
      terrorist = terrorist - (terrorist * 0.01).toInt();
    }
  }

  dailyChanges() {
    money = money + tax * population.value;
    dataBox.put("money", money);
  }

  // buildSchool() {
  //   if (money >= 1000000) {
  //     school = dataBox.get("schoolNum") + 1;
  //     dataBox.put("schoolNum", school);
  //   } else {
  //     Fluttertoast.showToast(msg: "Yeterli paranız yok");
  //   }
  // }

  // buildFactory() {
  //   if (factoryNum < 400) {
  //     if (dataBox.get("money") >= 1000000) {
  //       factoryNum = dataBox.get("factoryNum") + 1;
  //       dataBox.put("factoryNum", factoryNum);
  //     } else {
  //       Fluttertoast.showToast(msg: "Yeterli paranız yok");
  //     }
  //   } else {
  //     Fluttertoast.showToast(msg: "Maksimum sayıda fabrika inşaa edildi.");
  //   }
  // }

    // Stream dateStream = Stream.fromFuture(dateTimer());
  // final oneSec = Duration(seconds: 3);
  // Future dateTimer() async {
  //   Timer.periodic(
  //     oneSec,
  //     (Timer t) {
  //       setDate();
  //       t.cancel();
  //     },
  //   );
  //   return dataBox.get("time");
  // }

  // ValueListenableBuilder<int>(
                    //   valueListenable: population,
                    //   builder: (BuildContext context, dynamic value, Widget? child) {
                    //     return Container(
                    //       padding: const EdgeInsets.all(8),
                    //       child: Text(
                    //         "Nüfus: " + population.value.toString(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // StreamBuilder(
                    //   stream: dateStream,
                    //   builder: (context, snaphot) {
                    //     print(snaphot.data);
                    //     return Container(
                    //       child: Text(
                    //         "Tarih: " + DateFormat("yMd").format(date),
                    //       ),
                    //     );
                    //   },
                    // ),

 
}
