
;
; @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;

[section .text]
global memcpy_avx512
;
; void *memcpy_avx512(void *dst, const void *src, size_t len);
;
; RDI = dst
; RSI = src
; RDX = len
;
memcpy_avx512:
  xor rcx, rcx
  mov rax, rdi
._loop:
  cmp rdx, 512
  jge .jge_512      ; If the length is greater than or equal to 512.
  cmp rdx, 256
  jge .jge_256      ; If the length is greater than or equal to 256.
  cmp rdx, 128
  jge .jge_128      ; If the length is greater than or equal to 128.
  cmp rdx, 64
  jge .jge_64       ; If the length is greater than or equal to 64.
  cmp rdx, 32
  jge .jge_32       ; If the length is greater than or equal to 32.
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
  sub rdx, 512
  add rcx, 512
  test rdx, rdx
  jnz ._loop
  jmp .epi

.jge_256:
  prefetcht1 [rsi + rcx + (16 * 0)]
  prefetcht1 [rsi + rcx + (16 * 1)]
  prefetcht1 [rsi + rcx + (16 * 2)]
  prefetcht1 [rsi + rcx + (16 * 3)]
  prefetcht1 [rsi + rcx + (16 * 4)]
  prefetcht1 [rsi + rcx + (16 * 5)]
  prefetcht1 [rsi + rcx + (16 * 6)]
  prefetcht1 [rsi + rcx + (16 * 7)]
  prefetcht1 [rsi + rcx + (16 * 8)]
  prefetcht1 [rsi + rcx + (16 * 9)]
  prefetcht1 [rsi + rcx + (16 * 10)]
  prefetcht1 [rsi + rcx + (16 * 11)]
  prefetcht1 [rsi + rcx + (16 * 12)]
  prefetcht1 [rsi + rcx + (16 * 13)]
  prefetcht1 [rsi + rcx + (16 * 14)]
  prefetcht1 [rsi + rcx + (16 * 15)]
  prefetcht1 [rdi + rcx + (16 * 0)]
  prefetcht1 [rdi + rcx + (16 * 1)]
  prefetcht1 [rdi + rcx + (16 * 2)]
  prefetcht1 [rdi + rcx + (16 * 3)]
  prefetcht1 [rdi + rcx + (16 * 4)]
  prefetcht1 [rdi + rcx + (16 * 5)]
  prefetcht1 [rdi + rcx + (16 * 6)]
  prefetcht1 [rdi + rcx + (16 * 7)]
  prefetcht1 [rdi + rcx + (16 * 8)]
  prefetcht1 [rdi + rcx + (16 * 9)]
  prefetcht1 [rdi + rcx + (16 * 10)]
  prefetcht1 [rdi + rcx + (16 * 11)]
  prefetcht1 [rdi + rcx + (16 * 12)]
  prefetcht1 [rdi + rcx + (16 * 13)]
  prefetcht1 [rdi + rcx + (16 * 14)]
  prefetcht1 [rdi + rcx + (16 * 15)]
  vmovdqu xmm0, [rsi + rcx + (16 * 0)]
  vmovdqu xmm1, [rsi + rcx + (16 * 1)]
  vmovdqu xmm2, [rsi + rcx + (16 * 2)]
  vmovdqu xmm3, [rsi + rcx + (16 * 3)]
  vmovdqu xmm4, [rsi + rcx + (16 * 4)]
  vmovdqu xmm5, [rsi + rcx + (16 * 5)]
  vmovdqu xmm6, [rsi + rcx + (16 * 6)]
  vmovdqu xmm7, [rsi + rcx + (16 * 7)]
  vmovdqu xmm8, [rsi + rcx + (16 * 8)]
  vmovdqu xmm9, [rsi + rcx + (16 * 9)]
  vmovdqu xmm10, [rsi + rcx + (16 * 10)]
  vmovdqu xmm11, [rsi + rcx + (16 * 11)]
  vmovdqu xmm12, [rsi + rcx + (16 * 12)]
  vmovdqu xmm13, [rsi + rcx + (16 * 13)]
  vmovdqu xmm14, [rsi + rcx + (16 * 14)]
  vmovdqu xmm15, [rsi + rcx + (16 * 15)]
  vmovdqu [rdi + rcx + (16 * 0)], xmm0
  vmovdqu [rdi + rcx + (16 * 1)], xmm1
  vmovdqu [rdi + rcx + (16 * 2)], xmm2
  vmovdqu [rdi + rcx + (16 * 3)], xmm3
  vmovdqu [rdi + rcx + (16 * 4)], xmm4
  vmovdqu [rdi + rcx + (16 * 5)], xmm5
  vmovdqu [rdi + rcx + (16 * 6)], xmm6
  vmovdqu [rdi + rcx + (16 * 7)], xmm7
  vmovdqu [rdi + rcx + (16 * 8)], xmm8
  vmovdqu [rdi + rcx + (16 * 9)], xmm9
  vmovdqu [rdi + rcx + (16 * 10)], xmm10
  vmovdqu [rdi + rcx + (16 * 11)], xmm11
  vmovdqu [rdi + rcx + (16 * 12)], xmm12
  vmovdqu [rdi + rcx + (16 * 13)], xmm13
  vmovdqu [rdi + rcx + (16 * 14)], xmm14
  vmovdqu [rdi + rcx + (16 * 15)], xmm15
  sub rdx, 256
  add rcx, 256
  test rdx, rdx
  jnz ._loop
  jmp .epi

.jge_128:
  prefetcht1 [rsi + rcx + (16 * 0)]
  prefetcht1 [rsi + rcx + (16 * 1)]
  prefetcht1 [rsi + rcx + (16 * 2)]
  prefetcht1 [rsi + rcx + (16 * 3)]
  prefetcht1 [rsi + rcx + (16 * 4)]
  prefetcht1 [rsi + rcx + (16 * 5)]
  prefetcht1 [rsi + rcx + (16 * 6)]
  prefetcht1 [rsi + rcx + (16 * 7)]
  prefetcht1 [rdi + rcx + (16 * 0)]
  prefetcht1 [rdi + rcx + (16 * 1)]
  prefetcht1 [rdi + rcx + (16 * 2)]
  prefetcht1 [rdi + rcx + (16 * 3)]
  prefetcht1 [rdi + rcx + (16 * 4)]
  prefetcht1 [rdi + rcx + (16 * 5)]
  prefetcht1 [rdi + rcx + (16 * 6)]
  prefetcht1 [rdi + rcx + (16 * 7)]
  vmovdqu xmm0, [rsi + rcx + (16 * 0)]
  vmovdqu xmm1, [rsi + rcx + (16 * 1)]
  vmovdqu xmm2, [rsi + rcx + (16 * 2)]
  vmovdqu xmm3, [rsi + rcx + (16 * 3)]
  vmovdqu xmm4, [rsi + rcx + (16 * 4)]
  vmovdqu xmm5, [rsi + rcx + (16 * 5)]
  vmovdqu xmm6, [rsi + rcx + (16 * 6)]
  vmovdqu xmm7, [rsi + rcx + (16 * 7)]
  vmovdqu [rdi + rcx + (16 * 0)], xmm0
  vmovdqu [rdi + rcx + (16 * 1)], xmm1
  vmovdqu [rdi + rcx + (16 * 2)], xmm2
  vmovdqu [rdi + rcx + (16 * 3)], xmm3
  vmovdqu [rdi + rcx + (16 * 4)], xmm4
  vmovdqu [rdi + rcx + (16 * 5)], xmm5
  vmovdqu [rdi + rcx + (16 * 6)], xmm6
  vmovdqu [rdi + rcx + (16 * 7)], xmm7
  sub rdx, 128
  add rcx, 128
  test rdx, rdx
  jnz ._loop
  jmp .epi

.jge_32:


.epi:
  ret
