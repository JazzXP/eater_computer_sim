import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutputView extends StatelessWidget {
  const OutputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        children: [
          Text('Output'),
          Text('${state.outputData}'),
        ],
      ),
    );
  }
}
