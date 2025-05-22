import 'package:flutter/material.dart';
import 'package:smart_foot_pad/Utils/ThemeManager.dart';

class MyContainer extends StatelessWidget {
  final Widget widget;
  final bool colored;

  const MyContainer({super.key, required this.widget, this.colored = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color:
            !colored
                ? ThemeManager.containerColor
                : ThemeManager.coloredContainerColor,
        elevation: 0,
        child: Padding(padding: const EdgeInsets.all(20), child: widget),
      ),
    );
  }
}
