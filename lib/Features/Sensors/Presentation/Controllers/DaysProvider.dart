import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_foot_pad/Features/Sensors/Data/SensorsRepository.dart';
import 'package:smart_foot_pad/Features/Sensors/Domain/ReportModel.dart';

import '../../Domain/SensorsDataModel.dart';

part 'DaysProvider.g.dart';

const double _minOxygen = 95;
const double _maxHumidity = 60;
const double _maxTemp = 2.2;

@riverpod
Future<List<DateTime>> getDays(GetDaysRef ref) async {
  await Future.delayed(const Duration(seconds: 2));

  //TODO: Remove test Badge
  return ref
      .watch(sensorsRepositoryProvider)
      .requireValue
      .getAvailableDays(isTest: false);
}

@riverpod
Future<ReportModel> sensorReadsByDay(
  SensorReadsByDayRef ref,
  DateTime dateTime,
) async {
  /*
  DateTime time = DateTime.now();
  await Future.delayed(const Duration(seconds: 2));
  List<SensorsDataModel> rawReads = Iterable.generate(
    1000,
    (index) => SensorsDataModel(
      Random().nextInt(10) + 90,
      Random().nextInt(30) + 60,
      Random().nextInt(4) + 33,
      time.add(
        Duration(seconds: 10),
      ),
    ),
  ).toList();

  */
  List<SensorsDataModel> rawReads = ref
      .watch(sensorsRepositoryProvider)
      .requireValue
      .getReadsByDate(dateTime);
  ReadTypeOverall oxygen = buildReadTypeOverall(
    ReadType.oxygen,
    rawReads
        .map<SingleValueRead>((e) => (date: e.snapshotTime, val: e.oxygen))
        .toList(),
  );
  ReadTypeOverall humidity = buildReadTypeOverall(
    ReadType.humidity,
    rawReads
        .map<SingleValueRead>((e) => (date: e.snapshotTime, val: e.humidity))
        .toList(),
  );

  return ReportModel(
    readsNumber: rawReads.length,
    reads: {ReadType.oxygen: oxygen, ReadType.humidity: humidity},
  );
}

ReadTypeOverall buildReadTypeOverall(
  ReadType readType,
  List<SingleValueRead> reads,
) {
  if (reads.isEmpty) {
    return (avg: -1, outOfRangeReads: [], mostCritical: -1);
  }
  double avg = 0;
  double mostCritical = reads.first.val;
  List<SingleValueRead> criticalReads = [];
  reads.forEach((element) {
    avg = avg + element.val;
    if (isCriticalVal(readType, element.val)) {
      criticalReads.add((date: element.date, val: element.val));
      if (isMoreCritical(readType, mostCritical, element.val)) {
        mostCritical = element.val;
      }
    }

    print(
      "Most Critical : ${mostCritical}, Current Val : ${element.val}, avg: ${avg}",
    );
  });

  return (
    outOfRangeReads: criticalReads,
    mostCritical: isCriticalVal(readType, mostCritical) ? mostCritical : -1,
    avg: avg / reads.length,
  );
}

double initialCriticalValue(ReadType readType, List<SingleValueRead> values) {
  switch (readType) {
    case ReadType.oxygen:
      return values
          .firstWhere(
            (element) => element.val < _minOxygen,
            orElse: () => (date: DateTime.now(), val: -1),
          )
          .val;
    case ReadType.humidity:
      return values
          .firstWhere(
            (element) => element.val > _maxHumidity,
            orElse: () => (date: DateTime.now(), val: -1),
          )
          .val;
    case ReadType.temperature:
  }
  return -1;
}

bool isMoreCritical(ReadType readType, double current, double newVal) {
  switch (readType) {
    case ReadType.oxygen:
      if (newVal < current) return true;
    case ReadType.humidity:
      if (newVal > current) return true;
    case ReadType.temperature:
    // TODO: Handle this case.
  }
  return false;
}

bool isCriticalVal(ReadType read, double value) {
  switch (read) {
    case ReadType.oxygen:
      if (value < _minOxygen) {
        return true;
      }
    case ReadType.humidity:
      if (value > _maxHumidity) return true;
    case ReadType.temperature:
      if (value > _maxTemp) return true;
  }
  return false;
}
