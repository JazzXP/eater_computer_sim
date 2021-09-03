import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RAMView extends StatelessWidget {
  const RAMView({Key? key}) : super(key: key);

  String _ramText(List<int> ram) {
    StringBuffer out = StringBuffer();
    for (int i = 0; i < ram.length; i += 8) {
      for (int j = 0; j < 8; j++) {
        out.write(ram[i + j]);
      }
      out.write('\n');
    }
    return out.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          Text('RAM'),
          Text(_ramText(state.memory)),
        ],
      ),
    );
  }
}
