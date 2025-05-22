import 'dart:ui';

import 'package:hive/hive.dart';

part 'SensorsDataModel.g.dart';

@HiveType(typeId: 0)
class SensorsDataModel extends HiveObject {
  @HiveField(0)
  double oxygen;
  @HiveField(1)
  double humidity;
  @HiveField(2)
  double temperature;
  @HiveField(3)
  DateTime snapshotTime;

  SensorsDataModel(
      this.oxygen, this.humidity, this.temperature, this.snapshotTime);

  factory SensorsDataModel.fromString(String rawVal) {
    var valList = rawVal.split(",");
    return SensorsDataModel(double.parse(valList[2]), double.parse(valList[1]),
        double.parse(valList[0]), DateTime.now());
  }

  @override
  String toString() {
    return 'SensorsDataModel{val1: $oxygen, val2: $humidity, snapshotTime: $snapshotTime}';
  }
}
