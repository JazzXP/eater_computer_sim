import 'dart:async';

import 'package:eater_computer/src/bloc/bloc.dart';
import 'package:eater_computer/src/components/reset.dart';
import 'package:eater_computer/src/constants.dart';
import 'package:eater_computer/src/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colors.blueAccent,
        child: BlocProvider<IoBloc>(
          create: (context) {
            var bloc = IoBloc();
            List<int> prog = List.filled(64, 0);
            prog[0] = assemblyTokens.LDA.index << 4 | 15;
            prog[1] = assemblyTokens.ADD.index << 4 | 14;
            prog[2] = assemblyTokens.OUT.index << 4;
            prog[3] = assemblyTokens.HLT.index << 4;
            prog[14] = 3;
            prog[15] = 0;
            bloc.add(MemoryLoad(prog));
            Timer.periodic(Duration(milliseconds: 500), (timer) {
              if (bloc.state.autoClock) {
                bloc.add(Tick());
              }
            });
            return bloc;
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 8.0,
              ),
              child: Column(
                children: [
                  DatabusView(),
                  ClockView(),
                  MARView(),
                  RAMView(),
                  InstructionRegisterView(),
                  ProgramCounterView(),
                  RegisterView(Reg.A),
                  ALUView(),
                  RegisterView(Reg.B),
                  OutputView(),
                  ControlView(),
                  ResetButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
