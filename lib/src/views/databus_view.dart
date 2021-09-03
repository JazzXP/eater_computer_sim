import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/led.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabusView extends StatelessWidget {
  const DatabusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          Text('Databus'),
          Row(
            children: [
              LED(state.databus & 0x1 == 0x1),
              LED(state.databus & 0x2 == 0x2),
              LED(state.databus & 0x4 == 0x4),
              LED(state.databus & 0x8 == 0x8),
              LED(state.databus & 0x01 == 0x01),
              LED(state.databus & 0x02 == 0x02),
              LED(state.databus & 0x04 == 0x04),
              LED(state.databus & 0x08 == 0x08),
            ],
          )
        ],
      ),
    );
  }
}
