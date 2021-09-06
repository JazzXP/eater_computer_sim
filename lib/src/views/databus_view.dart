import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabusView extends StatelessWidget {
  const DatabusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          ModuleTitle('Databus'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LED(state.databus & 0x01 == 0x01),
              LED(state.databus & 0x02 == 0x02),
              LED(state.databus & 0x04 == 0x04),
              LED(state.databus & 0x08 == 0x08),
              LED(state.databus & 0x10 == 0x10),
              LED(state.databus & 0x20 == 0x20),
              LED(state.databus & 0x40 == 0x40),
              LED(state.databus & 0x80 == 0x80),
            ],
          )
        ],
      ),
    );
  }
}
