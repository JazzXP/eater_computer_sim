import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:eater_computer/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructionRegisterView extends StatelessWidget {
  const InstructionRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            ModuleTitle(
              'Instruction Register',
              input: state.control & ctlII == ctlII,
              output: state.control & ctlIO == ctlIO,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LED(state.instruction & 0x10 == 0x10),
                LED(state.instruction & 0x20 == 0x20),
                LED(state.instruction & 0x40 == 0x40),
                LED(state.instruction & 0x80 == 0x80),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${state.instruction >> 4}',
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
