import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/led.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView(this.register, {Key? key}) : super(key: key);
  final Reg register;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(builder: (context, state) {
      int val = register == Reg.A ? state.areg : state.breg;
      return Column(
        children: [
          Text('Register ${register == Reg.A ? 'A' : 'B'}'),
          Row(
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
      );
    });
  }
}
