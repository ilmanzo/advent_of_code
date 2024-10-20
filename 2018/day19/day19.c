#include <stdio.h>

int registers[6];
void run(void);

void zero_registers(void) {
  for (int n = 0; n < 6; n += 1) { registers[n] = 0; }
}

int main(void) {
  zero_registers();
  run();
  printf("Part 1: %d\n", registers[0]);
  zero_registers();
  registers[0] = 1;
  run();
  printf("Part 2: %d\n", registers[0]);
  return 0;
}

void run(void) {
  int ip = 0;
  void *labels[] = {
    &&instr_0,
    &&instr_1,
    &&instr_2,
    &&instr_3,
    &&instr_4,
    &&instr_5,
    &&instr_6,
    &&instr_7,
    &&instr_8,
    &&instr_9,
    &&instr_10,
    &&instr_11,
    &&instr_12,
    &&instr_13,
    &&instr_14,
    &&instr_15,
    &&instr_16,
    &&instr_17,
    &&instr_18,
    &&instr_19,
    &&instr_20,
    &&instr_21,
    &&instr_22,
    &&instr_23,
    &&instr_24,
    &&instr_25,
    &&instr_26,
    &&instr_27,
    &&instr_28,
    &&instr_29,
    &&instr_30,
    &&instr_31,
    &&instr_32,
    &&instr_33,
    &&instr_34,
    &&instr_35,
  };
  instr_0:
  registers[2] = ip;
  registers[2] = registers[2] + 16;
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_1:
  registers[5] = 1;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_2:
  registers[3] = 1;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_3:
  registers[4] = registers[5] * registers[3];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_4:
  registers[4] = registers[4] == registers[1];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_5:
  registers[2] = ip;
  registers[2] = registers[4] + registers[2];
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_6:
  registers[2] = ip;
  registers[2] = registers[2] + 1;
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_7:
  registers[0] = registers[5] + registers[0];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_8:
  registers[3] = registers[3] + 1;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_9:
  registers[4] = registers[3] > registers[1];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_10:
  registers[2] = ip;
  registers[2] = registers[2] + registers[4];
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_11:
  registers[2] = ip;
  registers[2] = 2;
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_12:
  registers[5] = registers[5] + 1;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_13:
  registers[4] = registers[5] > registers[1];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_14:
  registers[2] = ip;
  registers[2] = registers[4] + registers[2];
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_15:
  registers[2] = ip;
  registers[2] = 1;
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_16:
  registers[2] = ip;
  registers[2] = registers[2] * registers[2];
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_17:
  registers[1] = registers[1] + 2;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_18:
  registers[1] = registers[1] * registers[1];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_19:
  registers[2] = ip;
  registers[1] = registers[2] * registers[1];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_20:
  registers[1] = registers[1] * 11;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_21:
  registers[4] = registers[4] + 2;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_22:
  registers[2] = ip;
  registers[4] = registers[4] * registers[2];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_23:
  registers[4] = registers[4] + 12;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_24:
  registers[1] = registers[1] + registers[4];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_25:
  registers[2] = ip;
  registers[2] = registers[2] + registers[0];
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_26:
  registers[2] = ip;
  registers[2] = 0;
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_27:
  registers[2] = ip;
  registers[4] = registers[2];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_28:
  registers[2] = ip;
  registers[4] = registers[4] * registers[2];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_29:
  registers[2] = ip;
  registers[4] = registers[2] + registers[4];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_30:
  registers[2] = ip;
  registers[4] = registers[2] * registers[4];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_31:
  registers[4] = registers[4] * 14;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_32:
  registers[2] = ip;
  registers[4] = registers[4] * registers[2];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_33:
  registers[1] = registers[1] + registers[4];
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_34:
  registers[0] = 0;
  ip += 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
  instr_35:
  registers[2] = ip;
  registers[2] = 0;
  ip = registers[2] + 1;
  if (ip >= 36) { return; }
  goto *labels[ip];
}
