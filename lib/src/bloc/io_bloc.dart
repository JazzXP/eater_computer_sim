import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../constants.dart';

part 'io_event.dart';
part 'io_state.dart';

class IoBloc extends Bloc<IoEvent, IoState> {
  int databus = 0;
  late final List<Function> modules;
  IoBloc() : super(IoInitial()) {
    modules = [
      ramOut,
      instructionRegisterOut,
      programCounterOut,
      registerAOut,
      aluOut,
      moduleMARIn,
      ramIn,
      instructionRegisterIn,
      programCounterIn,
      registerAIn,
      registerBIn,
      aluIn,
      outputIn,
      controlLogic,
    ];
  }

  @override
  Stream<IoState> mapEventToState(
    IoEvent event,
  ) async* {
    if (event is Reset) {
      _step = 0;
      yield IoUpdated(
          clock: false,
          autoClock: state.autoClock,
          databus: 0,
          control: 0,
          controlStep: 0,
          mar: 0,
          memory: state.memory,
          instruction: 0,
          pc: 0,
          areg: 0,
          breg: 0,
          aluresult: 0,
          zeroflag: false,
          overflow: false,
          outputData: 0);
    } else if (event is Tick) {
      if ((state.control & ctlHLT) != ctlHLT) {
        yield IoUpdated(
            clock: !state.clock,
            autoClock: state.autoClock,
            databus: state.databus,
            control: state.control,
            controlStep: _step,
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
      }
    } else if (event is AutoClock) {
      yield IoUpdated(
          clock: state.clock,
          autoClock: event.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: event.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: event.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
    } else if (event is MemoryLoad) {
      yield IoUpdated(
          clock: state.clock,
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
          mar: state.mar,
          memory: event.mem,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
              autoClock: state.autoClock,
              databus: state.databus,
              control: state.control,
              controlStep: _step,
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
              autoClock: state.autoClock,
              databus: state.databus,
              control: state.control,
              controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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
          autoClock: state.autoClock,
          databus: state.databus,
          control: state.control,
          controlStep: _step,
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

  void moduleMARIn() {
    var MI = (state.control & ctlMI) == ctlMI;
    if (state.clock && MI) {
      add(MemoryAddressRegister(this.databus));
    }
  }

  void ramIn() {
    if (state.clock && state.control & ctlRI == ctlRI) {
      add(Memory(this.databus));
    }
  }

  void ramOut() {
    var RO = (state.control & ctlRO) == ctlRO;
    if (state.clock && RO) {
      add(Databus(state.memory[state.mar]));
      databus = state.memory[state.mar];
    }
  }

  void instructionRegisterIn() {
    var II = (state.control & ctlII) == ctlII;
    if (state.clock && II) {
      add(Instruction(this.databus));
    }
  }

  void instructionRegisterOut() {
    var IO = (state.control & ctlIO) == ctlIO;
    if (state.clock && IO) {
      add(Databus(state.instruction));
      databus = state.instruction;
    }
  }

  void programCounterIn() {
    if (state.clock && state.control & ctlCE == ctlCE) {
      add(ProgramCounterIncrement());
    }
    var J = (state.control & ctlJ) == ctlJ;
    if (state.clock && J) {
      add(ProgramCounterJump(this.databus & 0x0f));
    }
  }

  void programCounterOut() {
    var CO = (state.control & ctlCO) == ctlCO;
    if (state.clock && CO) {
      add(Databus(this.databus & 0xf0 | state.pc & 0x0f));
      this.databus = this.databus & 0xf0 | state.pc & 0x0f;
    }
  }

  void registerAIn() {
    var AI = (state.control & ctlAI) == ctlAI;
    if (state.clock && AI) {
      add(Register(Reg.A, this.databus));
    }
  }

  void registerAOut() {
    var AO = (state.control & ctlAO) == ctlAO;
    if (state.clock && AO) {
      add(Databus(state.areg));
      databus = state.areg;
    }
  }

  void registerBIn() {
    var BI = (state.control & ctlBI) == ctlBI;
    if (state.clock && BI) {
      add(Register(Reg.B, this.databus));
    }
  }

  void aluIn() {
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
  }

  void aluOut() {
    var EO = (state.control & ctlEO) == ctlEO;
    if (state.clock && EO) {
      add(Databus(state.aluresult));
      databus = state.aluresult;
    }
  }

  void outputIn() {
    if (state.clock && state.control & ctlOI == ctlOI) {
      add(OutputData(this.databus));
    }
  }

  int _step = 0;
  void controlLogic() {
    if (!state.clock) {
      switch (assemblyTokens.values[state.instruction >> 4]) {
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
              break;
            case 4:
              add(Control(0));
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
              break;
            case 4:
              add(Control(0));
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
              break;
            case 3:
              add(Control(0));
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
              break;
            case 3:
              add(Control(0));
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
              break;
            case 3:
              add(Control(0));
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
              break;
            case 3:
              add(Control(0));
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
              break;
            case 3:
              add(Control(0));
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
              // _step = 0;
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
