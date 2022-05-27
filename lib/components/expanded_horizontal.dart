import 'package:flutter/material.dart';

class ExpandedHorizontal extends StatelessWidget {
  final Widget child;

  const ExpandedHorizontal({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
