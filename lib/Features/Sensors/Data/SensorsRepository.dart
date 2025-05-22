import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_foot_pad/Features/Sensors/Domain/SensorsDataModel.dart';

part 'SensorsRepository.g.dart';

const String _sensorsBox = "SensorsBox";
const String _daysBox = "DaysBox";

@Riverpod(keepAlive: true)
Future<SensorsRepository> sensorsRepository(SensorsRepositoryRef ref) async {
  var sensorsRepo = SensorsRepository(ref);
  await sensorsRepo.initRepository();
  await sensorsRepo.openBoxes();

  return sensorsRepo;
}

class SensorsRepository {
  final Ref ref;

  const SensorsRepository(this.ref);

  Future<void> initRepository() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SensorsDataModelAdapter());
    }
  }

  Future<void> openBoxes() async {
    await [_openDaysBox(), _openSensorsBox()].wait;
  }

  void addSensorRead(SensorsDataModel dataModel) {
    var box = _getSensorsBox();
    var daysBox = _getDaysBox();
    DateTime dataModelDate = DateTime(
      dataModel.snapshotTime.year,
      dataModel.snapshotTime.month,
      dataModel.snapshotTime.day,
    );
    box.add(dataModel);
    !daysBox.values.contains(dataModelDate) ? daysBox.add(dataModelDate) : null;
  }

  List<DateTime> getAvailableDays({bool isTest = false}) {
    if (isTest) {
      DateTime now = DateTime.now();
      List<DateTime> dates = [];
      for (int i = 0; i < 5; i++) {
        now = now.subtract(const Duration(hours: 25));
        dates.add(now);
      }
      return dates;
    }
    var daysBox = _getDaysBox();
    return daysBox.values.toList();
  }

  List<SensorsDataModel> getReadsByDate(DateTime date) {
    var box = _getSensorsBox();
    var list =
        box.values.where((element) {
          return _sameDay(element.snapshotTime, date);
        }).toList();
    return list;
  }

  bool _sameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> clearDB() async {
    var sensorsBox = _getSensorsBox();
    var daysBox = _getDaysBox();
    await sensorsBox.clear();
    daysBox.clear();
  }

  Box<SensorsDataModel> _getSensorsBox() => Hive.box(_sensorsBox);
  Box<DateTime> _getDaysBox() => Hive.box(_daysBox);

  // internal functions
  Future<Box<SensorsDataModel>> _openSensorsBox() async =>
      await Hive.openBox<SensorsDataModel>(_sensorsBox);

  Future<Box<DateTime>> _openDaysBox() async =>
      await Hive.openBox<DateTime>(_daysBox);
}
