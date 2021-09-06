part of 'io_bloc.dart';

@immutable
abstract class IoEvent {}

class Reset extends IoEvent {}

class Tick extends IoEvent {}

class AutoClock extends IoEvent {
  final bool autoClock;
  AutoClock(this.autoClock) : super();
}

class Databus extends IoEvent {
  final int databus;
  Databus(this.databus) : super() {
    if (this.databus != 0) {
      print('Databus set');
    }
  }
}

class Control extends IoEvent {
  final int control;
  Control(this.control) : super();
}

class MemoryAddressRegister extends IoEvent {
  late final int mar;
  MemoryAddressRegister(mar) : super() {
    this.mar = mar & 0x0f;
  }
}

class Memory extends IoEvent {
  final int mem;
  Memory(this.mem) : super();
}

class MemoryLoad extends IoEvent {
  final List<int> mem;
  MemoryLoad(this.mem) : super();
}

class Instruction extends IoEvent {
  final int instruction;
  Instruction(this.instruction) : super();
}

class ProgramCounterIncrement extends IoEvent {}

class ProgramCounterJump extends IoEvent {
  final int pc;
  ProgramCounterJump(this.pc) : super();
}

class Register extends IoEvent {
  final Reg register;
  final int val;
  Register(this.register, this.val) : super();
}

class ALUResult extends IoEvent {
  final int alu;
  ALUResult(this.alu) : super();
}

class Overflow extends IoEvent {
  final bool overflow;
  Overflow(this.overflow) : super();
}

class OutputData extends IoEvent {
  final int outputData;
  OutputData(this.outputData) : super();
}
