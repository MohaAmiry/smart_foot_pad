import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_foot_pad/Features/pedometerFeature/Presentation/Controllers/StepsController.dart';
import 'package:smart_foot_pad/Utils/Extensions.dart';
import 'package:smart_foot_pad/Utils/ThemeManager.dart';

import '../Data/StepsRepository.dart';

@RoutePage()
class StepsView extends ConsumerWidget {
  const StepsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Today's Steps")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ref
                  .watch(stepsTodayStreamProvider)
                  .when(
                    data:
                        (data) => Text(
                          data.toString(),
                          style: ThemeManager.largeLabelStyle.copyWith(
                            fontSize: 150,
                          ),
                        ),
                    error: (error, stackTrace) {
                      return Text("${error.toString()}+ Stack: $stackTrace}");
                    },
                    loading:
                        () => Text(
                          ref
                              .read(stepsRepositoryProvider)
                              .requireValue
                              .getStepsByDay()
                              .toString(),
                          style: ThemeManager.largeLabelStyle.copyWith(
                            fontSize: 150,
                          ),
                        ),
                  ),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daily Reports",
                    style: ThemeManager.coloredTitlesStyle,
                  ),
                  IconButton(
                    onPressed: () => ref.invalidate(getAllStepsDaysProvider),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              ref
                  .watch(getAllStepsDaysProvider)
                  .maybeWhen(
                    data:
                        (data) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: Text(
                                  "At ${data.elementAt(index).date.toRegularDate()}, You've Walked ${data.elementAt(index).steps} Steps",
                                ),
                              ),
                        ),
                    orElse: () => const Text("Loading"),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
