part of 'io_bloc.dart';

@immutable
abstract class IoState {
  final bool clock;
  final bool autoClock;
  final int databus;
  final int control;
  final int controlStep;
  final int mar;
  final List<int> memory;
  final int instruction;
  final int pc;
  final int areg;
  final int breg;
  final int aluresult;
  final bool zeroflag;
  final bool overflow;
  final int outputData;
  IoState({
    required this.clock,
    required this.autoClock,
    required this.databus,
    required this.control,
    required this.controlStep,
    required this.mar,
    required this.memory,
    required this.instruction,
    required this.pc,
    required this.areg,
    required this.breg,
    required this.aluresult,
    required this.zeroflag,
    required this.overflow,
    required this.outputData,
  }) : super();
}

class IoInitial extends IoState {
  IoInitial()
      : super(
          clock: false,
          autoClock: true,
          databus: 0,
          control: 0,
          controlStep: 0,
          mar: 0,
          memory: List.filled(64, 0),
          instruction: 0,
          pc: 0,
          areg: 0,
          breg: 0,
          aluresult: 0,
          zeroflag: false,
          overflow: false,
          outputData: 0,
        );
}

class IoUpdated extends IoState {
  IoUpdated({
    required bool clock,
    required bool autoClock,
    required int databus,
    required int control,
    required int controlStep,
    required int mar,
    required List<int> memory,
    required int instruction,
    required int pc,
    required int areg,
    required int breg,
    required int aluresult,
    required bool zeroflag,
    required bool overflow,
    required int outputData,
  }) : super(
          clock: clock,
          autoClock: autoClock,
          databus: databus,
          control: control,
          controlStep: controlStep,
          mar: mar,
          memory: memory,
          instruction: instruction,
          pc: pc,
          areg: areg,
          breg: breg,
          aluresult: aluresult,
          zeroflag: zeroflag,
          overflow: overflow,
          outputData: outputData,
        );
}
