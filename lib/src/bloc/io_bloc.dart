import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../constants.dart';

part 'io_event.dart';
part 'io_state.dart';

class IoBloc extends Bloc<IoEvent, IoState> {
  late final List<Function> modules;
  IoBloc() : super(IoInitial()) {
    modules = [
      moduleMAR,
      ram,
      instructionRegister,
      programCounter,
      registerA,
      registerB,
      alu,
      output,
    ];
  }

  @override
  Stream<IoState> mapEventToState(
    IoEvent event,
  ) async* {
    if (event is Tick) {
      yield IoUpdated(
          clock: !state.clock,
          databus: state.databus,
          control: state.control | ctlMI,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is Databus) {
      yield IoUpdated(
          clock: state.clock,
          databus: event.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is Control) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: event.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is MemoryAddressRegister) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: event.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is Memory) {
      List<int> newMem = List.from(state.memory);
      newMem[state.mar] = event.mem;
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: newMem,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is Instruction) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: event.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is ProgramCounterIncrement) {
      int pc = state.pc;
      pc++;
      if (pc > 8) {
        pc = 0;
      }
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is ProgramCounterJump) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: event.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is Register) {
      switch (event.register) {
        case Reg.A:
          yield IoUpdated(
              clock: state.clock,
              databus: state.databus,
              control: state.control,
              mar: state.mar,
              memory: state.memory,
              instruction: state.instruction,
              pc: state.pc,
              areg: event.val,
              breg: state.breg,
              aluresult: state.aluresult,
              zeroflag: state.zeroflag,
              overflow: state.overflow,
              outputData: state.outputData);
          break;
        case Reg.B:
          yield IoUpdated(
              clock: state.clock,
              databus: state.databus,
              control: state.control,
              mar: state.mar,
              memory: state.memory,
              instruction: state.instruction,
              pc: state.pc,
              areg: state.areg,
              breg: event.val,
              aluresult: state.aluresult,
              zeroflag: state.zeroflag,
              overflow: state.overflow,
              outputData: state.outputData);
          break;
      }
    } else if (event is ALUResult) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: event.alu,
          zeroflag: event.alu == 0,
          overflow: state.overflow,
          outputData: state.outputData);
    } else if (event is Overflow) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: event.overflow,
          outputData: state.outputData);
    } else if (event is OutputData) {
      yield IoUpdated(
          clock: state.clock,
          databus: state.databus,
          control: state.control,
          mar: state.mar,
          memory: state.memory,
          instruction: state.instruction,
          pc: state.pc,
          areg: state.areg,
          breg: state.breg,
          aluresult: state.aluresult,
          zeroflag: state.zeroflag,
          overflow: state.overflow,
          outputData: event.outputData);
    }
  }

  @override
  void onEvent(IoEvent event) {
    super.onEvent(event);
    if (event is Tick) {
      modules.forEach((element) => element());
    }
  }

  void moduleMAR() {
    if (state.clock && state.control & ctlMI == ctlMI) {
      add(MemoryAddressRegister(state.databus));
    }
  }

  void ram() {
    if (state.control & ctlRI == ctlRI) {
      add(Memory(state.databus));
    }
    if (state.control & ctlRO == ctlRO) {
      add(Databus(state.memory[state.mar]));
    }
  }

  void instructionRegister() {
    if (state.control & ctlIO == ctlIO) {
      add(Databus(state.instruction));
    }
    if (state.control & ctlII == ctlII) {
      add(Instruction(state.databus));
    }
  }

  void programCounter() {
    if (state.control & ctlCE == ctlCE) {
      add(ProgramCounterIncrement());
    }
    if (state.control & ctlCO == ctlCO) {
      add(Databus(state.databus & 0xf0 | state.pc & 0x0f));
    }
    if (state.control & ctlJ == ctlJ) {
      add(ProgramCounterJump(state.databus & 0x0f));
    }
  }

  void registerA() {
    if (state.control & ctlAI == ctlAI) {
      add(Register(Reg.A, state.databus));
    }
    if (state.control & ctlAO == ctlAO) {
      add(Databus(state.areg));
    }
  }

  void registerB() {
    if (state.control & ctlBI == ctlBI) {
      add(Register(Reg.B, state.databus));
    }
  }

  void alu() {
    if (state.control & ctlSU == ctlSU) {
      int aluResult = state.areg - state.breg;
      if (aluResult < 0) {
        aluResult += 255;
        add(Overflow(true));
      }
      add(ALUResult(aluResult));
    } else {
      int aluResult = state.areg + state.breg;
      if (aluResult > 255) {
        aluResult -= 255;
        add(Overflow(true));
      }
      add(ALUResult(aluResult));
    }

    if (state.control & ctlEO == ctlEO) {
      add(Databus(state.aluresult));
    }
  }

  void output() {
    if (state.control & ctlOI == ctlOI) {
      add(OutputData(state.databus));
    }
  }
}
