import 'package:eater_computer/src/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<IoBloc>(context).add(Reset());
        },
        child: Text('Reset'));
  }
}
