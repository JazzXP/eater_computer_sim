import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/module_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class OutputView extends StatelessWidget {
  const OutputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            ModuleTitle(
              'Output',
              input: state.control & ctlOI == ctlOI,
            ),
            Text('${state.outputData}'),
          ],
        ),
      ),
    );
  }
}
