import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/led.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MARView extends StatelessWidget {
  const MARView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Memory Address Register'),
            Text('${state.mar}'),
            Row(
              children: [
                LED(state.mar & 0x1 == 0x1),
                LED(state.mar & 0x2 == 0x2),
                LED(state.mar & 0x4 == 0x4),
                LED(state.mar & 0x8 == 0x8),
              ],
            )
          ],
        );
      },
    );
  }
}
