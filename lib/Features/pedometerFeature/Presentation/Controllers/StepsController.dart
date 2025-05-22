import 'dart:async';

import 'package:hive/hive.dart';
import 'package:pedometer/pedometer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_foot_pad/Features/pedometerFeature/Data/StepsRepository.dart';

import '../../Domain/StepsModel.dart';

part 'StepsController.g.dart';

@riverpod
Future<List<AllStepsDaysModel>> getAllStepsDays(GetAllStepsDaysRef ref) async {
  return ref.watch(stepsRepositoryProvider).requireValue.getAllDaysAllSteps();
}

@riverpod
Stream<StepCount> stepsStream(StepsStreamRef ref) {
  ref.read(stepsRepositoryProvider).requireValue.initToday();
  return Pedometer.stepCountStream..listen((event) {
    print("inside: $event");
    ref.read(stepsRepositoryProvider).requireValue.setTodaySteps();
  });
}

@riverpod
Stream<int> stepsTodayStream(StepsTodayStreamRef ref) {
  ref.read(stepsRepositoryProvider).requireValue.initToday();
  var stream = ref.read(stepsRepositoryProvider).requireValue.getTodayStream();
  StreamTransformer<BoxEvent, int> transformer = StreamTransformer.fromHandlers(
    handleData: (data, sink) => sink.add(data.value),
    handleDone: (sink) => sink.close(),
    handleError: (error, stackTrace, sink) => sink.add(-1),
  );
  return stream.transform(transformer);
}
