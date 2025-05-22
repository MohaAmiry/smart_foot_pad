import 'package:smart_foot_pad/Features/pedometerFeature/Domain/StepsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'StepsRepository.g.dart';

const _stepsBox = "StepsBox";

@Riverpod(keepAlive: true)
Future<StepsRepository> stepsRepository(StepsRepositoryRef ref) async {
  var repo = StepsRepository(ref);
  await repo.openBoxes();
  return repo;
}

@Riverpod(keepAlive: true)
DateTime today(TodayRef ref) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

class StepsRepository {
  final Ref ref;

  const StepsRepository(this.ref);

  void initToday() {
    var box = getStepsBox();
    var current = box.get(ref.read(todayProvider).toString());
    if (current == null) {
      box.put(ref.read(todayProvider).toString(), 0);
      return;
    }
  }

  Future<void> openBoxes() async {
    await _openStepsBox();
  }

  void setTodaySteps() {
    var box = getStepsBox();
    int current = box.get(ref.read(todayProvider).toString())!;
    box.put(ref.read(todayProvider).toString(), current + 1);
  }

  List<AllStepsDaysModel> getAllDaysAllSteps() {
    var box = getStepsBox();
    return box
        .toMap()
        .entries
        .map((e) => (date: DateTime.parse(e.key), steps: e.value))
        .toList();
  }

  int getStepsByDay() {
    var box = getStepsBox();
    var result = box.get(ref.read(todayProvider).toString());
    if (result == null) {
      box.put(ref.read(todayProvider).toString(), 0);
      return 0;
    }
    return result;
  }

  Stream<BoxEvent> getTodayStream() {
    return getStepsBox().watch(key: ref.read(todayProvider).toString());
  }

  Future<void> clearDB() async {
    var stepsBox = getStepsBox();
    await stepsBox.clear();
  }

  Box<int> getStepsBox() => Hive.box(_stepsBox);

  // internal functions
  Future<Box<int>> _openStepsBox() async => await Hive.openBox<int>(_stepsBox);
}
