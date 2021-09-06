import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:eater_computer/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramCounterView extends StatelessWidget {
  const ProgramCounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            ModuleTitle(
              'Program Counter',
              input: state.control & ctlJ == ctlJ,
              output: state.control & ctlCO == ctlCO,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LED(state.pc & 0x01 == 0x01),
                LED(state.pc & 0x02 == 0x02),
                LED(state.pc & 0x04 == 0x04),
                LED(state.pc & 0x08 == 0x08),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${state.pc}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
