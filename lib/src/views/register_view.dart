import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class RegisterView extends StatelessWidget {
  const RegisterView(this.register, {Key? key}) : super(key: key);
  final Reg register;

  Widget buildTitle(IoState state) {
    switch (register) {
      case Reg.A:
        return ModuleTitle(
          'Register A',
          input: state.control & ctlAI == ctlAI,
          output: state.control & ctlAO == ctlAO,
        );
      case Reg.B:
        return ModuleTitle(
          'Register B',
          input: state.control & ctlBI == ctlBI,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(builder: (context, state) {
      int val = register == Reg.A ? state.areg : state.breg;
      return Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            ModuleTitle('Register ${register == Reg.A ? 'A' : 'B'}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LED(val & 0x01 == 0x01),
                LED(val & 0x02 == 0x02),
                LED(val & 0x04 == 0x04),
                LED(val & 0x08 == 0x08),
                LED(val & 0x10 == 0x10),
                LED(val & 0x20 == 0x20),
                LED(val & 0x40 == 0x40),
                LED(val & 0x80 == 0x80),
              ],
            )
          ],
        ),
      );
    });
  }
}
