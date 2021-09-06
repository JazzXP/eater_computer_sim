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
        home: Layout());
  }
}

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: BlocProvider<IoBloc>(
        create: (context) {
          var bloc = IoBloc();
          List<int> prog = List.filled(16, 0);
          prog[0] = assemblyTokens.LDA.index << 4 | 15;
          prog[1] = assemblyTokens.ADD.index << 4 | 14;
          prog[2] = assemblyTokens.OUT.index << 4;
          prog[3] = assemblyTokens.JMP.index << 4 | 1;
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
          body: SafeArea(
            child: Flex(direction: Axis.vertical, children: [
              Flexible(
                flex: 1,
                child: ClockView(),
              ),
              Flexible(
                flex: 5,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MARView(),
                          RAMView(),
                          InstructionRegisterView(),
                          ControlView(),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          DatabusView(),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProgramCounterView(),
                          RegisterView(Reg.A),
                          ALUView(),
                          RegisterView(Reg.B),
                          OutputView(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: ResetButton(),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
