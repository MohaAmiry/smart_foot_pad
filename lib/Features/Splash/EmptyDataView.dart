import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyDataView extends ConsumerWidget {
  final String message;
  const EmptyDataView({super.key, this.message = "No Data Available"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
        child: Center(
      child: Text(message),
    ));
  }
}
