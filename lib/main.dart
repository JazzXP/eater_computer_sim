import 'dart:async';

import 'package:eater_computer/src/bloc/io_bloc.dart';
import 'package:eater_computer/src/views/clock_view.dart';
import 'package:eater_computer/src/views/databus_view.dart';
import 'package:eater_computer/src/views/mar_view.dart';
import 'package:eater_computer/src/views/ram_view.dart';
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
            Timer.periodic(Duration(seconds: 1), (timer) {
              bloc.add(Tick());
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
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatabusView(),
                  ClockView(),
                  MARView(),
                  RAMView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
