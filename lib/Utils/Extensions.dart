// app_localizations_context.dart
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String ifIsEmpty(String placeholder) => this.isEmpty ? placeholder : this;
}

extension DateFormatter on DateTime {
  String toRegularDate() => DateFormat("yyyy/MM/dd").format(this);
  String toHourDate() => DateFormat("hh:mm:ss a").format(this);
}

extension RefreshNotifiers<T> on AutoDisposeAsyncNotifier<T> {
  Future<void> myRefresh() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    ref.invalidateSelf();
  }
}

extension RefreshProviders<T> on Ref<AsyncValue<T>> {
  Future<void> myRefresh() async {
    const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    invalidateSelf();
  }
}
