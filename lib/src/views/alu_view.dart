import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class ALUView extends StatelessWidget {
  const ALUView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          ModuleTitle(
            'ALU',
            output: state.control & ctlEO == ctlEO,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LED(state.aluresult & 0x01 == 0x01),
              LED(state.aluresult & 0x02 == 0x02),
              LED(state.aluresult & 0x04 == 0x04),
              LED(state.aluresult & 0x08 == 0x08),
              LED(state.aluresult & 0x10 == 0x10),
              LED(state.aluresult & 0x20 == 0x20),
              LED(state.aluresult & 0x40 == 0x40),
              LED(state.aluresult & 0x80 == 0x80),
            ],
          )
        ],
      ),
    );
  }
}
