<?php

const RET_REG                = "rax";
const DST_REG                = "rdi";
const SRC_REG                = "rsi";
const LEN_REG                = "rdx";
const COUNTER_REG            = "rcx";
const TMP_REG                = ["r9", "r9d", "r9w", "r9b"];
const MAX_VEC_REGISTER_BIT   = 256;
const MAX_VEC_REGISTER_NUM   = 16;
const MAX_VEC_REGISTER_BYTES = MAX_VEC_REGISTER_NUM / 8;
const MAX_BRANCH_BYTES       = MAX_VEC_REGISTER_BIT * MAX_VEC_REGISTER_BYTES;


const VEC_BYTES = [
  "zmm" => 64,
  "ymm" => 32,
  "xmm" => 16
];

const APPROP_MOV = [
  "zmm" => "vmovdqu64",
  "ymm" => "vmovdqu",
  "xmm" => "vmovdqu",
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
  generate_branches($branches, $j, $mm);
  $branches .= sprintf("  add %s, %d\n", COUNTER_REG, $j);
  $branches .= sprintf("  sub %s, %d\n", LEN_REG, $j);
  $branches .= sprintf("  test rdx, rdx\n");
  $branches .= sprintf("  jnz ._loop\n");
  $branches .= sprintf("  jmp .epi\n");
  $mm /= 2;
  $j /= 2;
}


function generate_branches(string &$branches, int $j, int &$mm)
{
  switch (MAX_VEC_REGISTER_BIT) {
    case 512:
      if ($j < 32) {
        $mm = 1;
        $curReg = "xmm";
      } else
      if ($j < 64) {
        $mm = ($j <= 32) ? 1 : 2;
        $curReg = "ymm";
      } else {
        $curReg = "zmm";
      }

      for ($i = 0; $i < $mm; $i++) {
        $branches .= sprintf(
          "  prefetcht1 [%s + %s + (%d * %d)]\n",
          SRC_REG, COUNTER_REG, VEC_BYTES[$curReg], $i
        );
      }
      for ($i = 0; $i < $mm; $i++) { 
        $branches .= sprintf(
          "  prefetcht1 [%s + %s + (%d * %d)]\n",
          DST_REG, COUNTER_REG, VEC_BYTES[$curReg], $i
        );
      }
      for ($i = 0; $i < $mm; $i++) { 
        $branches .= sprintf(
          "  %s %s%d, [%s + %s + (%d * %d)]\n",
          APPROP_MOV[$curReg],
          $curReg, $i, SRC_REG, COUNTER_REG, VEC_BYTES[$curReg], $i
        );
      }
      for ($i = 0; $i < $mm; $i++) { 
        $branches .= sprintf(
          "  %s [%s + %s + (%d * %d)], %s%d\n",
          APPROP_MOV[$curReg],
          DST_REG, COUNTER_REG, VEC_BYTES[$curReg], $i, $curReg, $i
        );
      }
      break;

    case 256:
      if ($j < 32) {
        $mm = 1;
        $curReg = "xmm";
      } else
      if ($j < 64) {
        $mm = ($j <= 32) ? 1 : 2;
        $curReg = "ymm";
      } else {
        $curReg = "ymm";
      }

      for ($i = 0; $i < $mm; $i++) {
        $branches .= sprintf(
          "  prefetcht1 [%s + %s + (%d * %d)]\n",
          SRC_REG, COUNTER_REG, VEC_BYTES[$curReg], $i
        );
      }
      for ($i = 0; $i < $mm; $i++) { 
        $branches .= sprintf(
          "  prefetcht1 [%s + %s + (%d * %d)]\n",
          DST_REG, COUNTER_REG, VEC_BYTES[$curReg], $i
        );
      }
      for ($i = 0; $i < $mm; $i++) { 
        $branches .= sprintf(
          "  %s %s%d, [%s + %s + (%d * %d)]\n",
          APPROP_MOV[$curReg],
          $curReg, $i, SRC_REG, COUNTER_REG, VEC_BYTES[$curReg], $i
        );
      }
      for ($i = 0; $i < $mm; $i++) { 
        $branches .= sprintf(
          "  %s [%s + %s + (%d * %d)], %s%d\n",
          APPROP_MOV[$curReg],
          DST_REG, COUNTER_REG, VEC_BYTES[$curReg], $i, $curReg, $i
        );
      }
      break;
  }
}


$branches .= sprintf(<<<CODE
.jge_8:
  mov %s, [%s + %s]
  mov [%s + %s], %s
  add %s, 8
  sub %s, 8
  test %s, %s
  jnz ._loop

CODE,
TMP_REG[0],             SRC_REG, COUNTER_REG,
DST_REG, COUNTER_REG,   TMP_REG[0],
COUNTER_REG,
LEN_REG,
LEN_REG,                LEN_REG
);

$branches .= sprintf(<<<CODE
.jge_4:
  mov %s, [%s + %s]
  mov [%s + %s], %s
  add %s, 4
  sub %s, 4
  test %s, %s
  jnz ._loop

CODE,
TMP_REG[1],             SRC_REG, COUNTER_REG,
DST_REG, COUNTER_REG,   TMP_REG[1],
COUNTER_REG,
LEN_REG,
LEN_REG,                LEN_REG
);

$branches .= sprintf(<<<CODE
.jge_2:
  mov %s, [%s + %s]
  mov [%s + %s], %s
  add %s, 2
  sub %s, 2
  test %s, %s
  jnz ._loop

CODE,
TMP_REG[2],             SRC_REG, COUNTER_REG,
DST_REG, COUNTER_REG,   TMP_REG[2],
COUNTER_REG,
LEN_REG,
LEN_REG,                LEN_REG
);

$branches .= sprintf(<<<CODE
.jge_1:
  mov %s, [%s + %s]
  mov [%s + %s], %s

CODE,
TMP_REG[3],             SRC_REG, COUNTER_REG,
DST_REG, COUNTER_REG,   TMP_REG[3],);

printf(<<<CODE

;
; @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;

[section .text]
global memcpy_avx%d
;
; void *memcpy_avx512(void *dst, const void *src, size_t len);
;
; %s = dst
; %s = src
; %s = len
;
memcpy_avx%d:
  xor %s, %s
  mov %s, %s
._loop:
CODE,
MAX_VEC_REGISTER_BIT,
DST_REG,
SRC_REG,
LEN_REG,
MAX_VEC_REGISTER_BIT,
COUNTER_REG, COUNTER_REG, RET_REG, SRC_REG);
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
