import 'package:flutter/material.dart';

class LED extends StatelessWidget {
  const LED(this.on, {Key? key}) : super(key: key);
  final bool on;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      color: on ? Colors.red : Colors.white,
    );
  }
}
