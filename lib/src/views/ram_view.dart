import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/module_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class RAMView extends StatelessWidget {
  const RAMView({Key? key}) : super(key: key);

  String _ramText(List<int> ram) {
    StringBuffer out = StringBuffer();
    for (int i = 0; i < ram.length; i += 8) {
      for (int j = 0; j < 8; j++) {
        out.write(ram[i + j].toRadixString(16).padLeft(2, '0'));
        if (j < 7) {
          out.write(' ');
        }
      }
      out.write('\n');
    }
    return out.toString();
  }

  Widget buildRam(IoState state) {
    List<Widget> cols = [];
    for (int i = 0; i < state.memory.length; i += 8) {
      List<Widget> row = [];
      for (int j = 0; j < 8; j++) {
        row.add(Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            state.memory[i + j].toRadixString(16).padLeft(2, '0'),
            style: state.mar == (i + j)
                ? TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)
                : TextStyle(fontFamily: 'Courier'),
          ),
        ));
      }
      cols.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ));
    }
    return Column(
      children: cols,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          ModuleTitle(
            'RAM',
            input: state.control & ctlRI == ctlRI,
            output: state.control & ctlRO == ctlRO,
          ),
          buildRam(state),
        ],
      ),
    );
  }
}
