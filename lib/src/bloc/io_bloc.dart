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
      controlLogic,
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
    var MI = (state.control & ctlMI) == 0; // invert
    if (state.clock && MI) {
      add(MemoryAddressRegister(state.databus));
    }
  }

  void ram() {
    if (state.clock && state.control & ctlRI == ctlRI) {
      add(Memory(state.databus));
    }
    var RO = (state.control & ctlRO) == 0; // Invert
    if (state.clock && RO) {
      add(Databus(state.memory[state.mar]));
    }
  }

  void instructionRegister() {
    var IO = (state.control & ctlIO) == 0; // Invert
    if (state.clock && IO) {
      add(Databus(state.instruction));
    }
    var II = (state.control & ctlII) == 0; // Invert
    if (state.clock && II) {
      add(Instruction(state.databus));
    }
  }

  void programCounter() {
    if (state.clock && state.control & ctlCE == ctlCE) {
      add(ProgramCounterIncrement());
    }
    var CO = (state.control & ctlCO) == 0; // Invert
    if (state.clock && CO) {
      add(Databus(state.databus & 0xf0 | state.pc & 0x0f));
    }
    var J = (state.control & ctlJ) == 0; // Invert
    if (state.clock && J) {
      add(ProgramCounterJump(state.databus & 0x0f));
    }
  }

  void registerA() {
    var AI = (state.control & ctlAI) == 0; // Invert
    if (state.clock && AI) {
      add(Register(Reg.A, state.databus));
    }
    var AO = (state.control & ctlAO) == 0; // Invert
    if (state.clock && AO) {
      add(Databus(state.areg));
    }
  }

  void registerB() {
    var BI = (state.control & ctlBI) == 0; // Invert
    if (state.clock && BI) {
      add(Register(Reg.B, state.databus));
    }
  }

  void alu() {
    if (state.clock && state.control & ctlSU == ctlSU) {
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
    var EO = (state.control & ctlEO) == 0; // Invert
    if (state.clock && EO) {
      add(Databus(state.aluresult));
    }
  }

  void output() {
    if (state.clock && state.control & ctlOI == ctlOI) {
      add(OutputData(state.databus));
    }
  }

  int _step = 0;
  void controlLogic() {
    if (!state.clock) {
      switch (assemblyTokens.values[state.instruction]) {
        case assemblyTokens.LDA:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlMI));
              break;
            case 3:
              add(Control(ctlRO | ctlAI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.ADD:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlMI));
              break;
            case 3:
              add(Control(ctlRO | ctlBI));
              break;
            case 4:
              add(Control(ctlEO | ctlAI | ctlFI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.SUB:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlMI));
              break;
            case 3:
              add(Control(ctlRO | ctlBI));
              break;
            case 4:
              add(Control(ctlEO | ctlAI | ctlSU | ctlFI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.STA:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlMI));
              break;
            case 3:
              add(Control(ctlAO | ctlRI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.STA:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlMI));
              break;
            case 3:
              add(Control(ctlAO | ctlRI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.LDI:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlAI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.JMP:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | ctlJ));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.JC:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | (state.overflow ? ctlJ : 0)));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.JZ:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlIO | (state.zeroflag ? ctlJ : 0)));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.OUT:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlAO | ctlOI));
              _step = 0;
              return;
          }
          break;
        case assemblyTokens.HLT:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            case 2:
              add(Control(ctlHLT));
              _step = 0;
              return;
          }
          break;
        default:
          switch (_step) {
            case 0:
              add(Control(ctlCO | ctlMI));
              break;
            case 1:
              add(Control(ctlRO | ctlII | ctlCE));
              break;
            default:
              add(Control(0));
              _step = 0;
              return;
          }
          break;
      }
      _step++;
    }
  }
}
