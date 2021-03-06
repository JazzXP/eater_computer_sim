final int ctlHLT = int.parse("0000000000000001", radix: 2);
final int ctlMI = int.parse("0000000000000010", radix: 2);
final int ctlRI = int.parse("0000000000000100", radix: 2);
final int ctlRO = int.parse("0000000000001000", radix: 2);
final int ctlIO = int.parse("0000000000010000", radix: 2);
final int ctlII = int.parse("0000000000100000", radix: 2);
final int ctlAI = int.parse("0000000001000000", radix: 2);
final int ctlAO = int.parse("0000000010000000", radix: 2);
final int ctlEO = int.parse("0000000100000000", radix: 2);
final int ctlSU = int.parse("0000001000000000", radix: 2);
final int ctlBI = int.parse("0000010000000000", radix: 2);
final int ctlOI = int.parse("0000100000000000", radix: 2);
final int ctlCE = int.parse("0001000000000000", radix: 2);
final int ctlCO = int.parse("0010000000000000", radix: 2);
final int ctlJ = int.parse("0100000000000000", radix: 2);
final int ctlFI = int.parse("1000000000000000", radix: 2);

enum assemblyTokens {
  NOP,
  LDA,
  ADD,
  SUB,
  STA,
  LDI,
  JMP,
  JC,
  JZ,
  UNDEF1,
  UNDEF2,
  UNDEF3,
  UNDEF4,
  UNDEF5,
  OUT,
  HLT,
}

enum Reg {
  A,
  B,
}
