import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabusView extends StatelessWidget {
  const DatabusView({Key? key}) : super(key: key);

  Widget buildLEDRow(IoState state, int bitmask) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        LED(state.databus & bitmask == bitmask),
        Expanded(
          child: Container(
            color: Colors.black,
            width: 2.0,
            height: 200.0,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Expanded(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: [
              ModuleTitle('Databus'),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLEDRow(state, 0x01),
                    buildLEDRow(state, 0x02),
                    buildLEDRow(state, 0x04),
                    buildLEDRow(state, 0x08),
                    buildLEDRow(state, 0x10),
                    buildLEDRow(state, 0x20),
                    buildLEDRow(state, 0x40),
                    buildLEDRow(state, 0x80),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
