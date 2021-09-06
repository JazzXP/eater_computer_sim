import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/led.dart';
import 'package:eater_computer/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  Widget buildItem(String name, bool value) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Text(name),
          LED(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          Text('Control'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildItem('HLT', state.control & ctlHLT == ctlHLT),
              buildItem('MI', state.control & ctlMI == ctlMI),
              buildItem('RI', state.control & ctlRI == ctlRI),
              buildItem('RO', state.control & ctlRO == ctlRO),
              buildItem('IO', state.control & ctlIO == ctlIO),
              buildItem('II', state.control & ctlII == ctlII),
              buildItem('AI', state.control & ctlAI == ctlAI),
              buildItem('AO', state.control & ctlAO == ctlAO),
              buildItem('EO', state.control & ctlEO == ctlEO),
              buildItem('SU', state.control & ctlSU == ctlSU),
              buildItem('BI', state.control & ctlBI == ctlBI),
              buildItem('OI', state.control & ctlOI == ctlOI),
              buildItem('CE', state.control & ctlCE == ctlCE),
              buildItem('CO', state.control & ctlCO == ctlCO),
              buildItem('J', state.control & ctlJ == ctlJ),
              buildItem('FI', state.control & ctlFI == ctlFI),
            ],
          ),
          Text('${assemblyTokens.values[state.instruction]}'
              .substring('assemblyTokens.'.length)),
        ],
      ),
    );
  }
}