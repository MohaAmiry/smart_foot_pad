import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingView extends ConsumerWidget {
  final String message;

  const LoadingView({super.key, this.message = "Loading"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text(message));
  }
}
