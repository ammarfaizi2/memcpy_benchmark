
;
; @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;

[section .text]
global memcpy_avx256
;
; void *memcpy_avx512(void *dst, const void *src, size_t len);
;
; rdi = dst
; rsi = src
; rdx = len
;
memcpy_avx256:
  xor rcx, rcx
  mov rax, rsi
._loop:
  cmp rcx, 512
  jmp .jge_512        ; If the length is greater than or equal to 512
  cmp rcx, 256
  jmp .jge_256        ; If the length is greater than or equal to 256
  cmp rcx, 128
  jmp .jge_128        ; If the length is greater than or equal to 128
  cmp rcx, 64
  jmp .jge_64        ; If the length is greater than or equal to 64
  cmp rcx, 32
  jmp .jge_32        ; If the length is greater than or equal to 32
  cmp rcx, 16
  jmp .jge_16        ; If the length is greater than or equal to 16
  cmp rcx, 8
  jge .jge_8         ; If the length is greater than or equal to 8
  cmp rcx, 4
  jge .jge_4         ; If the length is greater than or equal to 4
  cmp rcx, 2
  jge .jge_2         ; If the length is greater than or equal to 2
  cmp rcx, 1
  jge .jge_1         ; If the length is greater than or equal to 1
  jmp .epi
.jge_512:
  prefetcht1 [rsi + rcx + (32 * 0)]
  prefetcht1 [rsi + rcx + (32 * 1)]
  prefetcht1 [rsi + rcx + (32 * 2)]
  prefetcht1 [rsi + rcx + (32 * 3)]
  prefetcht1 [rsi + rcx + (32 * 4)]
  prefetcht1 [rsi + rcx + (32 * 5)]
  prefetcht1 [rsi + rcx + (32 * 6)]
  prefetcht1 [rsi + rcx + (32 * 7)]
  prefetcht1 [rsi + rcx + (32 * 8)]
  prefetcht1 [rsi + rcx + (32 * 9)]
  prefetcht1 [rsi + rcx + (32 * 10)]
  prefetcht1 [rsi + rcx + (32 * 11)]
  prefetcht1 [rsi + rcx + (32 * 12)]
  prefetcht1 [rsi + rcx + (32 * 13)]
  prefetcht1 [rsi + rcx + (32 * 14)]
  prefetcht1 [rsi + rcx + (32 * 15)]
  prefetcht1 [rdi + rcx + (32 * 0)]
  prefetcht1 [rdi + rcx + (32 * 1)]
  prefetcht1 [rdi + rcx + (32 * 2)]
  prefetcht1 [rdi + rcx + (32 * 3)]
  prefetcht1 [rdi + rcx + (32 * 4)]
  prefetcht1 [rdi + rcx + (32 * 5)]
  prefetcht1 [rdi + rcx + (32 * 6)]
  prefetcht1 [rdi + rcx + (32 * 7)]
  prefetcht1 [rdi + rcx + (32 * 8)]
  prefetcht1 [rdi + rcx + (32 * 9)]
  prefetcht1 [rdi + rcx + (32 * 10)]
  prefetcht1 [rdi + rcx + (32 * 11)]
  prefetcht1 [rdi + rcx + (32 * 12)]
  prefetcht1 [rdi + rcx + (32 * 13)]
  prefetcht1 [rdi + rcx + (32 * 14)]
  prefetcht1 [rdi + rcx + (32 * 15)]
  vmovdqu ymm0, [rsi + rcx + (32 * 0)]
  vmovdqu ymm1, [rsi + rcx + (32 * 1)]
  vmovdqu ymm2, [rsi + rcx + (32 * 2)]
  vmovdqu ymm3, [rsi + rcx + (32 * 3)]
  vmovdqu ymm4, [rsi + rcx + (32 * 4)]
  vmovdqu ymm5, [rsi + rcx + (32 * 5)]
  vmovdqu ymm6, [rsi + rcx + (32 * 6)]
  vmovdqu ymm7, [rsi + rcx + (32 * 7)]
  vmovdqu ymm8, [rsi + rcx + (32 * 8)]
  vmovdqu ymm9, [rsi + rcx + (32 * 9)]
  vmovdqu ymm10, [rsi + rcx + (32 * 10)]
  vmovdqu ymm11, [rsi + rcx + (32 * 11)]
  vmovdqu ymm12, [rsi + rcx + (32 * 12)]
  vmovdqu ymm13, [rsi + rcx + (32 * 13)]
  vmovdqu ymm14, [rsi + rcx + (32 * 14)]
  vmovdqu ymm15, [rsi + rcx + (32 * 15)]
  vmovdqu [rdi + rcx + (32 * 0)], ymm0
  vmovdqu [rdi + rcx + (32 * 1)], ymm1
  vmovdqu [rdi + rcx + (32 * 2)], ymm2
  vmovdqu [rdi + rcx + (32 * 3)], ymm3
  vmovdqu [rdi + rcx + (32 * 4)], ymm4
  vmovdqu [rdi + rcx + (32 * 5)], ymm5
  vmovdqu [rdi + rcx + (32 * 6)], ymm6
  vmovdqu [rdi + rcx + (32 * 7)], ymm7
  vmovdqu [rdi + rcx + (32 * 8)], ymm8
  vmovdqu [rdi + rcx + (32 * 9)], ymm9
  vmovdqu [rdi + rcx + (32 * 10)], ymm10
  vmovdqu [rdi + rcx + (32 * 11)], ymm11
  vmovdqu [rdi + rcx + (32 * 12)], ymm12
  vmovdqu [rdi + rcx + (32 * 13)], ymm13
  vmovdqu [rdi + rcx + (32 * 14)], ymm14
  vmovdqu [rdi + rcx + (32 * 15)], ymm15
  add rcx, 512
  sub rdx, 512
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_256:
  prefetcht1 [rsi + rcx + (32 * 0)]
  prefetcht1 [rsi + rcx + (32 * 1)]
  prefetcht1 [rsi + rcx + (32 * 2)]
  prefetcht1 [rsi + rcx + (32 * 3)]
  prefetcht1 [rsi + rcx + (32 * 4)]
  prefetcht1 [rsi + rcx + (32 * 5)]
  prefetcht1 [rsi + rcx + (32 * 6)]
  prefetcht1 [rsi + rcx + (32 * 7)]
  prefetcht1 [rdi + rcx + (32 * 0)]
  prefetcht1 [rdi + rcx + (32 * 1)]
  prefetcht1 [rdi + rcx + (32 * 2)]
  prefetcht1 [rdi + rcx + (32 * 3)]
  prefetcht1 [rdi + rcx + (32 * 4)]
  prefetcht1 [rdi + rcx + (32 * 5)]
  prefetcht1 [rdi + rcx + (32 * 6)]
  prefetcht1 [rdi + rcx + (32 * 7)]
  vmovdqu ymm0, [rsi + rcx + (32 * 0)]
  vmovdqu ymm1, [rsi + rcx + (32 * 1)]
  vmovdqu ymm2, [rsi + rcx + (32 * 2)]
  vmovdqu ymm3, [rsi + rcx + (32 * 3)]
  vmovdqu ymm4, [rsi + rcx + (32 * 4)]
  vmovdqu ymm5, [rsi + rcx + (32 * 5)]
  vmovdqu ymm6, [rsi + rcx + (32 * 6)]
  vmovdqu ymm7, [rsi + rcx + (32 * 7)]
  vmovdqu [rdi + rcx + (32 * 0)], ymm0
  vmovdqu [rdi + rcx + (32 * 1)], ymm1
  vmovdqu [rdi + rcx + (32 * 2)], ymm2
  vmovdqu [rdi + rcx + (32 * 3)], ymm3
  vmovdqu [rdi + rcx + (32 * 4)], ymm4
  vmovdqu [rdi + rcx + (32 * 5)], ymm5
  vmovdqu [rdi + rcx + (32 * 6)], ymm6
  vmovdqu [rdi + rcx + (32 * 7)], ymm7
  add rcx, 256
  sub rdx, 256
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_128:
  prefetcht1 [rsi + rcx + (32 * 0)]
  prefetcht1 [rsi + rcx + (32 * 1)]
  prefetcht1 [rsi + rcx + (32 * 2)]
  prefetcht1 [rsi + rcx + (32 * 3)]
  prefetcht1 [rdi + rcx + (32 * 0)]
  prefetcht1 [rdi + rcx + (32 * 1)]
  prefetcht1 [rdi + rcx + (32 * 2)]
  prefetcht1 [rdi + rcx + (32 * 3)]
  vmovdqu ymm0, [rsi + rcx + (32 * 0)]
  vmovdqu ymm1, [rsi + rcx + (32 * 1)]
  vmovdqu ymm2, [rsi + rcx + (32 * 2)]
  vmovdqu ymm3, [rsi + rcx + (32 * 3)]
  vmovdqu [rdi + rcx + (32 * 0)], ymm0
  vmovdqu [rdi + rcx + (32 * 1)], ymm1
  vmovdqu [rdi + rcx + (32 * 2)], ymm2
  vmovdqu [rdi + rcx + (32 * 3)], ymm3
  add rcx, 128
  sub rdx, 128
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_64:
  prefetcht1 [rsi + rcx + (32 * 0)]
  prefetcht1 [rsi + rcx + (32 * 1)]
  prefetcht1 [rdi + rcx + (32 * 0)]
  prefetcht1 [rdi + rcx + (32 * 1)]
  vmovdqu ymm0, [rsi + rcx + (32 * 0)]
  vmovdqu ymm1, [rsi + rcx + (32 * 1)]
  vmovdqu [rdi + rcx + (32 * 0)], ymm0
  vmovdqu [rdi + rcx + (32 * 1)], ymm1
  add rcx, 64
  sub rdx, 64
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_32:
  prefetcht1 [rsi + rcx + (32 * 0)]
  prefetcht1 [rdi + rcx + (32 * 0)]
  vmovdqu ymm0, [rsi + rcx + (32 * 0)]
  vmovdqu [rdi + rcx + (32 * 0)], ymm0
  add rcx, 32
  sub rdx, 32
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_16:
  prefetcht1 [rsi + rcx + (16 * 0)]
  prefetcht1 [rdi + rcx + (16 * 0)]
  vmovdqu xmm0, [rsi + rcx + (16 * 0)]
  vmovdqu [rdi + rcx + (16 * 0)], xmm0
  add rcx, 16
  sub rdx, 16
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_8:
  mov r9, [rsi + rcx]
  mov [rdi + rcx], r9
  add rcx, 8
  sub rdx, 8
  test rdx, rdx
  jnz ._loop
.jge_4:
  mov r9d, [rsi + rcx]
  mov [rdi + rcx], r9d
  add rcx, 4
  sub rdx, 4
  test rdx, rdx
  jnz ._loop
.jge_2:
  mov r9w, [rsi + rcx]
  mov [rdi + rcx], r9w
  add rcx, 2
  sub rdx, 2
  test rdx, rdx
  jnz ._loop
.jge_1:
  mov r9b, [rsi + rcx]
  mov [rdi + rcx], r9b
.epi:
  ret
