import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_foot_pad/Features/Sensors/Presentation/Controllers/DaysProvider.dart';
import 'package:smart_foot_pad/Features/Splash/ErrorView.dart';
import 'package:smart_foot_pad/Features/_SharedWidgets/MyContainer.dart';
import 'package:smart_foot_pad/Utils/Extensions.dart';
import 'package:smart_foot_pad/Utils/ThemeManager.dart';

import '../Domain/ReportModel.dart';

@RoutePage()
class DailyReportView extends ConsumerWidget {
  final DateTime reportDate;

  const DailyReportView({super.key, required this.reportDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Daily Report")),
      backgroundColor: ThemeManager.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ref
              .watch(SensorReadsByDayProvider(reportDate))
              .when(
                data: (data) => report(reportDate, data),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => report(reportDate, null),
              ),
        ),
      ),
    );
  }

  Widget report(DateTime reportDate, ReportModel? reportModel) => Column(
    children: [
      MyContainer(
        colored: true,
        widget: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "Selected Day",
                style: ThemeManager.smallerTitlesStyle,
              ),
              Text(
                reportDate.toRegularDate(),
                style: ThemeManager.coloredSmallerTitlesStyle,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
      MyContainer(
        colored: true,
        widget: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "Reads Number Today",
                style: ThemeManager.smallerTitlesStyle,
              ),
              Text(
                "${reportModel?.readsNumber ?? "Loading"}",
                style: ThemeManager.coloredSensorStyle,
              ),
            ],
          ),
        ),
      ),
      const Divider(),
      getReadsReport(ReadType.oxygen, reportModel?.reads[ReadType.oxygen]),
      const Divider(),
      getReadsReport(ReadType.humidity, reportModel?.reads[ReadType.humidity]),
    ],
  );

  Widget getReadsReport(ReadType readType, ReadTypeOverall? reads) => Builder(
    builder: (context) {
      return Column(
        children: [
          Text(readType.title, style: ThemeManager.coloredTitlesStyle),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: singleValColumn("Daily Average", reads?.avg)),
                Expanded(
                  child: singleValColumn(
                    "Most Critical Value",
                    reads?.mostCritical,
                  ),
                ),
              ],
            ),
          ),
          const Text("Critical Reads", style: ThemeManager.smallerTitlesStyle),
          Padding(
            padding: const EdgeInsets.all(20),
            child:
                reads == null
                    ? const Text("Loading..")
                    : reads.outOfRangeReads.isEmpty
                    ? const Text(
                      "All Good! No Critical Reads Today.",
                      style: ThemeManager.bodyStyle,
                    )
                    : SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reads.outOfRangeReads.length,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.5,
                              ),
                              child: Text(
                                "${reads.outOfRangeReads.elementAt(index).date.toHourDate()} : ${reads.outOfRangeReads.elementAt(index).val.toStringAsFixed(2)} ${readType.unit}",
                                style: ThemeManager.bodyStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                      ),
                    ),
          ),
        ],
      );
    },
  );

  Widget singleValColumn(String text, double? val) => Padding(
    padding: const EdgeInsets.all(10),
    child: MyContainer(
      colored: val != null && val != -1,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: ThemeManager.smallerTitlesStyle,
          ),
          const SizedBox(width: 10),
          Text(
            val == null
                ? "Loading"
                : val == -1
                ? "--"
                : val.toStringAsFixed(2),
            style:
                val != null && val != -1
                    ? ThemeManager.coloredSensorStyle
                    : ThemeManager.titlesStyle,
          ),
        ],
      ),
    ),
  );
}
