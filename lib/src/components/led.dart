import 'package:flutter/material.dart';

class LED extends StatelessWidget {
  const LED(this.on, {Key? key, this.size = 20}) : super(key: key);
  final bool on;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: on ? Colors.red : Colors.red.shade100,
      ),
    );
  }
}
