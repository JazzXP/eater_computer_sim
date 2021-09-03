import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/led.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramCounterView extends StatelessWidget {
  const ProgramCounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          Text('Program Counter'),
          Row(
            children: [
              LED(state.instruction & 0x01 == 0x01),
              LED(state.instruction & 0x02 == 0x02),
              LED(state.instruction & 0x04 == 0x04),
              LED(state.instruction & 0x08 == 0x08),
            ],
          ),
        ],
      ),
    );
  }
}