<?php

const RET_REG                = "rax";
const DST_REG                = "rdi";
const SRC_REG                = "rsi";
const LEN_REG                = "rdx";
const COUNTER_REG            = "rcx";
const MAX_VEC_REGISTER_BIT   = 512;
const MAX_VEC_REGISTER_NUM   = 32;
const MAX_VEC_REGISTER_BYTES = MAX_VEC_REGISTER_NUM / 8;
const MAX_BRANCH_BYTES       = MAX_VEC_REGISTER_BIT * MAX_VEC_REGISTER_BYTES;


const VEC_BYTES = [
  "zmm" => 64,
  "ymm" => 32,
  "xmm" => 16
];


$j        = MAX_BRANCH_BYTES;
$loop     = "\n";
$branches = "\n";

$greatestVecReg = [
  512 => "zmm",
  256 => "ymm",
  128 => "xmm",
][MAX_VEC_REGISTER_BIT];

$mm = MAX_VEC_REGISTER_NUM;

while ($j >= 16) {
  $loop .= sprintf("  cmp %s, %d\n", COUNTER_REG, $j);
  $loop .= sprintf("  jmp .jge_%d        ", $j);
  $loop .= sprintf("; If the length is greater than or equal to %d\n", $j);

  $branches .= sprintf(".jge_%d:\n", $j);
  for ($i = 0; $i < $mm; $i++) {
    $branches .= sprintf(
      "  prefetcht1 [%s + %s + (%d * %d)]\n",
      SRC_REG, COUNTER_REG, VEC_BYTES["zmm"], $i
    );
  }
  for ($i = 0; $i < $mm; $i++) { 
    $branches .= sprintf(
      "  prefetcht1 [%s + %s + (%d * %d)]\n",
      DST_REG, COUNTER_REG, VEC_BYTES["zmm"], $i
    );
  }
  for ($i = 0; $i < $mm; $i++) { 
    $branches .= sprintf(
      "  vmovdqu zmm, [%s + %s + (%d * %d)]\n",
      SRC_REG, COUNTER_REG, VEC_BYTES["zmm"], $i
    );
  }
  $mm /= 2;
  $j /= 2;
}


printf(<<<CODE
memcpy_avx512:
  xor %s, %s
  mov %s, %s
._loop:
CODE, COUNTER_REG, COUNTER_REG, RET_REG, SRC_REG);
printf("%s", $loop);
printf(<<<CODE
  cmp %s, 8
  jge .jge_8         ; If the length is greater than or equal to 8
  cmp %s, 4
  jge .jge_4         ; If the length is greater than or equal to 4
  cmp %s, 2
  jge .jge_2         ; If the length is greater than or equal to 2
  cmp %s, 1
  jge .jge_1         ; If the length is greater than or equal to 1
  jmp .epi
CODE, COUNTER_REG, COUNTER_REG, COUNTER_REG, COUNTER_REG);
printf("%s", $branches);
printf(<<<CODE
.epi:
  ret

CODE);