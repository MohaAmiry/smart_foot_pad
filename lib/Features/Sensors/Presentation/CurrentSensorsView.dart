import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_foot_pad/Features/Sensors/Domain/CurrentSensorReadModel.dart';
import 'package:smart_foot_pad/Features/Sensors/Presentation/Controllers/DaysProvider.dart';
import 'package:smart_foot_pad/Features/Splash/ErrorView.dart';
import 'package:smart_foot_pad/Features/_SharedWidgets/MyContainer.dart';
import 'package:smart_foot_pad/Router/Router.gr.dart';
import 'package:smart_foot_pad/Utils/Extensions.dart';
import 'package:smart_foot_pad/Utils/ThemeManager.dart';

import 'Controllers/DeviceDataController.dart';

@RoutePage()
class SensorsView extends ConsumerStatefulWidget {
  const SensorsView({super.key});

  @override
  ConsumerState createState() => _SensorsViewState();
}

class _SensorsViewState extends ConsumerState<SensorsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sensors Current Reads"),
        leading: IconButton(
          onPressed: () => context.router.push(const DiscoverDevicesRoute()),
          icon: const Icon(Icons.bluetooth),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => ref.refresh(connectionProvider),
                  icon: const Icon(Icons.refresh),
                ),
              ),
              ref
                  .watch(deviceModelControllerProvider)
                  .when(
                    data:
                        (data) =>
                            data?.connection == null
                                ? Column(
                                  children: [
                                    const Text("The Device Is Not Connected"),
                                    sensorsReads(SensorReadLiveModel.empty()),
                                  ],
                                )
                                : sensorsReads(
                                  ref.watch(dataControllerProvider).value,
                                ),
                    error:
                        (error, stackTrace) => Column(
                          children: [
                            const Text(
                              "The Device Is Not Connected, Refresh The Page If You Think The Device Is Connected after 10 Seconds.",
                              textAlign: TextAlign.center,
                            ),
                            sensorsReads(SensorReadLiveModel.empty()),
                          ],
                        ),
                    loading: () => sensorsReads(null),
                  ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daily Reports",
                    style: ThemeManager.coloredTitlesStyle,
                  ),
                  IconButton(
                    onPressed: () => ref.invalidate(getDaysProvider),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              ref
                  .watch(getDaysProvider)
                  .when(
                    data:
                        (data) =>
                            data.isEmpty
                                ? const Text(
                                  "No Available Reports Yet",
                                  style: ThemeManager.bodyStyle,
                                )
                                : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder:
                                      (context, index) =>
                                          report(data.elementAt(index)),
                                ),
                    error: (error, stackTrace) => ErrorView(error: error),
                    loading: () => report(null),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sensorsReads(
    SensorReadLiveModel? readLiveModel, {
    bool? state,
  }) => Column(
    children: [
      IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: singleValColumn(
                "Oxygenation",
                readLiveModel?.oxygen,
                "SpO2",
              ),
            ),
            Expanded(
              child: singleValColumn("Humidity", readLiveModel?.humidity, "RH"),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: singleValColumn("Temperature", readLiveModel?.temperature, "C"),
      ),
    ],
  );

  Widget singleValColumn(String text, double? val, String unit) => Padding(
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
            "${val == null
                ? "Loading"
                : val == -1
                ? "--"
                : val}",
            style:
                val != null && val != -1
                    ? ThemeManager.coloredSensorStyle
                    : ThemeManager.titlesStyle,
          ),
          Text(unit, style: ThemeManager.titlesStyle),
        ],
      ),
    ),
  );

  Widget report(DateTime? dateTime) => Builder(
    builder: (context) {
      return InkWell(
        onTap:
            () =>
                dateTime == null
                    ? null
                    : context.router.push(
                      DailyReportRoute(reportDate: dateTime),
                    ),
        child: MyContainer(
          widget: SizedBox(
            width: double.infinity,
            child: Text(
              dateTime?.toRegularDate() ?? "Loading Available Reports",
              style: ThemeManager.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    },
  );
}
