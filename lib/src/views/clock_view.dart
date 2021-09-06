import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockView extends StatelessWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IoBloc, IoState>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ModuleTitle('Clock'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LED(state.clock),
              Text('Auto'),
              Checkbox(
                  value: state.autoClock,
                  onChanged: (event) {
                    BlocProvider.of<IoBloc>(context)
                        .add(AutoClock(!state.autoClock));
                  }),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<IoBloc>(context).add(Tick());
                  },
                  child: Text('Tick')),
            ],
          ),
        ],
      ),
    );
  }
}
