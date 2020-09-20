
;
; @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;

[section .text]
global memcpy_avx512
;
; void *memcpy_avx512(void *dst, const void *src, size_t len);
;
; rdi = dst
; rsi = src
; rdx = len
;
memcpy_avx512:
  xor rcx, rcx
  mov rax, rsi
._loop:
  cmp rcx, 2048
  jmp .jge_2048        ; If the length is greater than or equal to 2048
  cmp rcx, 1024
  jmp .jge_1024        ; If the length is greater than or equal to 1024
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
.jge_2048:
  prefetcht1 [rsi + rcx + (64 * 0)]
  prefetcht1 [rsi + rcx + (64 * 1)]
  prefetcht1 [rsi + rcx + (64 * 2)]
  prefetcht1 [rsi + rcx + (64 * 3)]
  prefetcht1 [rsi + rcx + (64 * 4)]
  prefetcht1 [rsi + rcx + (64 * 5)]
  prefetcht1 [rsi + rcx + (64 * 6)]
  prefetcht1 [rsi + rcx + (64 * 7)]
  prefetcht1 [rsi + rcx + (64 * 8)]
  prefetcht1 [rsi + rcx + (64 * 9)]
  prefetcht1 [rsi + rcx + (64 * 10)]
  prefetcht1 [rsi + rcx + (64 * 11)]
  prefetcht1 [rsi + rcx + (64 * 12)]
  prefetcht1 [rsi + rcx + (64 * 13)]
  prefetcht1 [rsi + rcx + (64 * 14)]
  prefetcht1 [rsi + rcx + (64 * 15)]
  prefetcht1 [rsi + rcx + (64 * 16)]
  prefetcht1 [rsi + rcx + (64 * 17)]
  prefetcht1 [rsi + rcx + (64 * 18)]
  prefetcht1 [rsi + rcx + (64 * 19)]
  prefetcht1 [rsi + rcx + (64 * 20)]
  prefetcht1 [rsi + rcx + (64 * 21)]
  prefetcht1 [rsi + rcx + (64 * 22)]
  prefetcht1 [rsi + rcx + (64 * 23)]
  prefetcht1 [rsi + rcx + (64 * 24)]
  prefetcht1 [rsi + rcx + (64 * 25)]
  prefetcht1 [rsi + rcx + (64 * 26)]
  prefetcht1 [rsi + rcx + (64 * 27)]
  prefetcht1 [rsi + rcx + (64 * 28)]
  prefetcht1 [rsi + rcx + (64 * 29)]
  prefetcht1 [rsi + rcx + (64 * 30)]
  prefetcht1 [rsi + rcx + (64 * 31)]
  prefetcht1 [rdi + rcx + (64 * 0)]
  prefetcht1 [rdi + rcx + (64 * 1)]
  prefetcht1 [rdi + rcx + (64 * 2)]
  prefetcht1 [rdi + rcx + (64 * 3)]
  prefetcht1 [rdi + rcx + (64 * 4)]
  prefetcht1 [rdi + rcx + (64 * 5)]
  prefetcht1 [rdi + rcx + (64 * 6)]
  prefetcht1 [rdi + rcx + (64 * 7)]
  prefetcht1 [rdi + rcx + (64 * 8)]
  prefetcht1 [rdi + rcx + (64 * 9)]
  prefetcht1 [rdi + rcx + (64 * 10)]
  prefetcht1 [rdi + rcx + (64 * 11)]
  prefetcht1 [rdi + rcx + (64 * 12)]
  prefetcht1 [rdi + rcx + (64 * 13)]
  prefetcht1 [rdi + rcx + (64 * 14)]
  prefetcht1 [rdi + rcx + (64 * 15)]
  prefetcht1 [rdi + rcx + (64 * 16)]
  prefetcht1 [rdi + rcx + (64 * 17)]
  prefetcht1 [rdi + rcx + (64 * 18)]
  prefetcht1 [rdi + rcx + (64 * 19)]
  prefetcht1 [rdi + rcx + (64 * 20)]
  prefetcht1 [rdi + rcx + (64 * 21)]
  prefetcht1 [rdi + rcx + (64 * 22)]
  prefetcht1 [rdi + rcx + (64 * 23)]
  prefetcht1 [rdi + rcx + (64 * 24)]
  prefetcht1 [rdi + rcx + (64 * 25)]
  prefetcht1 [rdi + rcx + (64 * 26)]
  prefetcht1 [rdi + rcx + (64 * 27)]
  prefetcht1 [rdi + rcx + (64 * 28)]
  prefetcht1 [rdi + rcx + (64 * 29)]
  prefetcht1 [rdi + rcx + (64 * 30)]
  prefetcht1 [rdi + rcx + (64 * 31)]
  vmovdqu64 zmm0, [rsi + rcx + (64 * 0)]
  vmovdqu64 zmm1, [rsi + rcx + (64 * 1)]
  vmovdqu64 zmm2, [rsi + rcx + (64 * 2)]
  vmovdqu64 zmm3, [rsi + rcx + (64 * 3)]
  vmovdqu64 zmm4, [rsi + rcx + (64 * 4)]
  vmovdqu64 zmm5, [rsi + rcx + (64 * 5)]
  vmovdqu64 zmm6, [rsi + rcx + (64 * 6)]
  vmovdqu64 zmm7, [rsi + rcx + (64 * 7)]
  vmovdqu64 zmm8, [rsi + rcx + (64 * 8)]
  vmovdqu64 zmm9, [rsi + rcx + (64 * 9)]
  vmovdqu64 zmm10, [rsi + rcx + (64 * 10)]
  vmovdqu64 zmm11, [rsi + rcx + (64 * 11)]
  vmovdqu64 zmm12, [rsi + rcx + (64 * 12)]
  vmovdqu64 zmm13, [rsi + rcx + (64 * 13)]
  vmovdqu64 zmm14, [rsi + rcx + (64 * 14)]
  vmovdqu64 zmm15, [rsi + rcx + (64 * 15)]
  vmovdqu64 zmm16, [rsi + rcx + (64 * 16)]
  vmovdqu64 zmm17, [rsi + rcx + (64 * 17)]
  vmovdqu64 zmm18, [rsi + rcx + (64 * 18)]
  vmovdqu64 zmm19, [rsi + rcx + (64 * 19)]
  vmovdqu64 zmm20, [rsi + rcx + (64 * 20)]
  vmovdqu64 zmm21, [rsi + rcx + (64 * 21)]
  vmovdqu64 zmm22, [rsi + rcx + (64 * 22)]
  vmovdqu64 zmm23, [rsi + rcx + (64 * 23)]
  vmovdqu64 zmm24, [rsi + rcx + (64 * 24)]
  vmovdqu64 zmm25, [rsi + rcx + (64 * 25)]
  vmovdqu64 zmm26, [rsi + rcx + (64 * 26)]
  vmovdqu64 zmm27, [rsi + rcx + (64 * 27)]
  vmovdqu64 zmm28, [rsi + rcx + (64 * 28)]
  vmovdqu64 zmm29, [rsi + rcx + (64 * 29)]
  vmovdqu64 zmm30, [rsi + rcx + (64 * 30)]
  vmovdqu64 zmm31, [rsi + rcx + (64 * 31)]
  vmovdqu64 [rdi + rcx + (64 * 0)], zmm0
  vmovdqu64 [rdi + rcx + (64 * 1)], zmm1
  vmovdqu64 [rdi + rcx + (64 * 2)], zmm2
  vmovdqu64 [rdi + rcx + (64 * 3)], zmm3
  vmovdqu64 [rdi + rcx + (64 * 4)], zmm4
  vmovdqu64 [rdi + rcx + (64 * 5)], zmm5
  vmovdqu64 [rdi + rcx + (64 * 6)], zmm6
  vmovdqu64 [rdi + rcx + (64 * 7)], zmm7
  vmovdqu64 [rdi + rcx + (64 * 8)], zmm8
  vmovdqu64 [rdi + rcx + (64 * 9)], zmm9
  vmovdqu64 [rdi + rcx + (64 * 10)], zmm10
  vmovdqu64 [rdi + rcx + (64 * 11)], zmm11
  vmovdqu64 [rdi + rcx + (64 * 12)], zmm12
  vmovdqu64 [rdi + rcx + (64 * 13)], zmm13
  vmovdqu64 [rdi + rcx + (64 * 14)], zmm14
  vmovdqu64 [rdi + rcx + (64 * 15)], zmm15
  vmovdqu64 [rdi + rcx + (64 * 16)], zmm16
  vmovdqu64 [rdi + rcx + (64 * 17)], zmm17
  vmovdqu64 [rdi + rcx + (64 * 18)], zmm18
  vmovdqu64 [rdi + rcx + (64 * 19)], zmm19
  vmovdqu64 [rdi + rcx + (64 * 20)], zmm20
  vmovdqu64 [rdi + rcx + (64 * 21)], zmm21
  vmovdqu64 [rdi + rcx + (64 * 22)], zmm22
  vmovdqu64 [rdi + rcx + (64 * 23)], zmm23
  vmovdqu64 [rdi + rcx + (64 * 24)], zmm24
  vmovdqu64 [rdi + rcx + (64 * 25)], zmm25
  vmovdqu64 [rdi + rcx + (64 * 26)], zmm26
  vmovdqu64 [rdi + rcx + (64 * 27)], zmm27
  vmovdqu64 [rdi + rcx + (64 * 28)], zmm28
  vmovdqu64 [rdi + rcx + (64 * 29)], zmm29
  vmovdqu64 [rdi + rcx + (64 * 30)], zmm30
  vmovdqu64 [rdi + rcx + (64 * 31)], zmm31
  add rcx, 2048
  sub rdx, 2048
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_1024:
  prefetcht1 [rsi + rcx + (64 * 0)]
  prefetcht1 [rsi + rcx + (64 * 1)]
  prefetcht1 [rsi + rcx + (64 * 2)]
  prefetcht1 [rsi + rcx + (64 * 3)]
  prefetcht1 [rsi + rcx + (64 * 4)]
  prefetcht1 [rsi + rcx + (64 * 5)]
  prefetcht1 [rsi + rcx + (64 * 6)]
  prefetcht1 [rsi + rcx + (64 * 7)]
  prefetcht1 [rsi + rcx + (64 * 8)]
  prefetcht1 [rsi + rcx + (64 * 9)]
  prefetcht1 [rsi + rcx + (64 * 10)]
  prefetcht1 [rsi + rcx + (64 * 11)]
  prefetcht1 [rsi + rcx + (64 * 12)]
  prefetcht1 [rsi + rcx + (64 * 13)]
  prefetcht1 [rsi + rcx + (64 * 14)]
  prefetcht1 [rsi + rcx + (64 * 15)]
  prefetcht1 [rdi + rcx + (64 * 0)]
  prefetcht1 [rdi + rcx + (64 * 1)]
  prefetcht1 [rdi + rcx + (64 * 2)]
  prefetcht1 [rdi + rcx + (64 * 3)]
  prefetcht1 [rdi + rcx + (64 * 4)]
  prefetcht1 [rdi + rcx + (64 * 5)]
  prefetcht1 [rdi + rcx + (64 * 6)]
  prefetcht1 [rdi + rcx + (64 * 7)]
  prefetcht1 [rdi + rcx + (64 * 8)]
  prefetcht1 [rdi + rcx + (64 * 9)]
  prefetcht1 [rdi + rcx + (64 * 10)]
  prefetcht1 [rdi + rcx + (64 * 11)]
  prefetcht1 [rdi + rcx + (64 * 12)]
  prefetcht1 [rdi + rcx + (64 * 13)]
  prefetcht1 [rdi + rcx + (64 * 14)]
  prefetcht1 [rdi + rcx + (64 * 15)]
  vmovdqu64 zmm0, [rsi + rcx + (64 * 0)]
  vmovdqu64 zmm1, [rsi + rcx + (64 * 1)]
  vmovdqu64 zmm2, [rsi + rcx + (64 * 2)]
  vmovdqu64 zmm3, [rsi + rcx + (64 * 3)]
  vmovdqu64 zmm4, [rsi + rcx + (64 * 4)]
  vmovdqu64 zmm5, [rsi + rcx + (64 * 5)]
  vmovdqu64 zmm6, [rsi + rcx + (64 * 6)]
  vmovdqu64 zmm7, [rsi + rcx + (64 * 7)]
  vmovdqu64 zmm8, [rsi + rcx + (64 * 8)]
  vmovdqu64 zmm9, [rsi + rcx + (64 * 9)]
  vmovdqu64 zmm10, [rsi + rcx + (64 * 10)]
  vmovdqu64 zmm11, [rsi + rcx + (64 * 11)]
  vmovdqu64 zmm12, [rsi + rcx + (64 * 12)]
  vmovdqu64 zmm13, [rsi + rcx + (64 * 13)]
  vmovdqu64 zmm14, [rsi + rcx + (64 * 14)]
  vmovdqu64 zmm15, [rsi + rcx + (64 * 15)]
  vmovdqu64 [rdi + rcx + (64 * 0)], zmm0
  vmovdqu64 [rdi + rcx + (64 * 1)], zmm1
  vmovdqu64 [rdi + rcx + (64 * 2)], zmm2
  vmovdqu64 [rdi + rcx + (64 * 3)], zmm3
  vmovdqu64 [rdi + rcx + (64 * 4)], zmm4
  vmovdqu64 [rdi + rcx + (64 * 5)], zmm5
  vmovdqu64 [rdi + rcx + (64 * 6)], zmm6
  vmovdqu64 [rdi + rcx + (64 * 7)], zmm7
  vmovdqu64 [rdi + rcx + (64 * 8)], zmm8
  vmovdqu64 [rdi + rcx + (64 * 9)], zmm9
  vmovdqu64 [rdi + rcx + (64 * 10)], zmm10
  vmovdqu64 [rdi + rcx + (64 * 11)], zmm11
  vmovdqu64 [rdi + rcx + (64 * 12)], zmm12
  vmovdqu64 [rdi + rcx + (64 * 13)], zmm13
  vmovdqu64 [rdi + rcx + (64 * 14)], zmm14
  vmovdqu64 [rdi + rcx + (64 * 15)], zmm15
  add rcx, 1024
  sub rdx, 1024
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_512:
  prefetcht1 [rsi + rcx + (64 * 0)]
  prefetcht1 [rsi + rcx + (64 * 1)]
  prefetcht1 [rsi + rcx + (64 * 2)]
  prefetcht1 [rsi + rcx + (64 * 3)]
  prefetcht1 [rsi + rcx + (64 * 4)]
  prefetcht1 [rsi + rcx + (64 * 5)]
  prefetcht1 [rsi + rcx + (64 * 6)]
  prefetcht1 [rsi + rcx + (64 * 7)]
  prefetcht1 [rdi + rcx + (64 * 0)]
  prefetcht1 [rdi + rcx + (64 * 1)]
  prefetcht1 [rdi + rcx + (64 * 2)]
  prefetcht1 [rdi + rcx + (64 * 3)]
  prefetcht1 [rdi + rcx + (64 * 4)]
  prefetcht1 [rdi + rcx + (64 * 5)]
  prefetcht1 [rdi + rcx + (64 * 6)]
  prefetcht1 [rdi + rcx + (64 * 7)]
  vmovdqu64 zmm0, [rsi + rcx + (64 * 0)]
  vmovdqu64 zmm1, [rsi + rcx + (64 * 1)]
  vmovdqu64 zmm2, [rsi + rcx + (64 * 2)]
  vmovdqu64 zmm3, [rsi + rcx + (64 * 3)]
  vmovdqu64 zmm4, [rsi + rcx + (64 * 4)]
  vmovdqu64 zmm5, [rsi + rcx + (64 * 5)]
  vmovdqu64 zmm6, [rsi + rcx + (64 * 6)]
  vmovdqu64 zmm7, [rsi + rcx + (64 * 7)]
  vmovdqu64 [rdi + rcx + (64 * 0)], zmm0
  vmovdqu64 [rdi + rcx + (64 * 1)], zmm1
  vmovdqu64 [rdi + rcx + (64 * 2)], zmm2
  vmovdqu64 [rdi + rcx + (64 * 3)], zmm3
  vmovdqu64 [rdi + rcx + (64 * 4)], zmm4
  vmovdqu64 [rdi + rcx + (64 * 5)], zmm5
  vmovdqu64 [rdi + rcx + (64 * 6)], zmm6
  vmovdqu64 [rdi + rcx + (64 * 7)], zmm7
  add rcx, 512
  sub rdx, 512
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_256:
  prefetcht1 [rsi + rcx + (64 * 0)]
  prefetcht1 [rsi + rcx + (64 * 1)]
  prefetcht1 [rsi + rcx + (64 * 2)]
  prefetcht1 [rsi + rcx + (64 * 3)]
  prefetcht1 [rdi + rcx + (64 * 0)]
  prefetcht1 [rdi + rcx + (64 * 1)]
  prefetcht1 [rdi + rcx + (64 * 2)]
  prefetcht1 [rdi + rcx + (64 * 3)]
  vmovdqu64 zmm0, [rsi + rcx + (64 * 0)]
  vmovdqu64 zmm1, [rsi + rcx + (64 * 1)]
  vmovdqu64 zmm2, [rsi + rcx + (64 * 2)]
  vmovdqu64 zmm3, [rsi + rcx + (64 * 3)]
  vmovdqu64 [rdi + rcx + (64 * 0)], zmm0
  vmovdqu64 [rdi + rcx + (64 * 1)], zmm1
  vmovdqu64 [rdi + rcx + (64 * 2)], zmm2
  vmovdqu64 [rdi + rcx + (64 * 3)], zmm3
  add rcx, 256
  sub rdx, 256
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_128:
  prefetcht1 [rsi + rcx + (64 * 0)]
  prefetcht1 [rsi + rcx + (64 * 1)]
  prefetcht1 [rdi + rcx + (64 * 0)]
  prefetcht1 [rdi + rcx + (64 * 1)]
  vmovdqu64 zmm0, [rsi + rcx + (64 * 0)]
  vmovdqu64 zmm1, [rsi + rcx + (64 * 1)]
  vmovdqu64 [rdi + rcx + (64 * 0)], zmm0
  vmovdqu64 [rdi + rcx + (64 * 1)], zmm1
  add rcx, 128
  sub rdx, 128
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_64:
  prefetcht1 [rsi + rcx + (64 * 0)]
  prefetcht1 [rdi + rcx + (64 * 0)]
  vmovdqu64 zmm0, [rsi + rcx + (64 * 0)]
  vmovdqu64 [rdi + rcx + (64 * 0)], zmm0
  add rcx, 64
  sub rdx, 64
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_32:
  prefetcht1 [rsi + rcx + (32 * 0)]
  prefetcht1 [rdi + rcx + (32 * 0)]
  vmovdqu64 ymm0, [rsi + rcx + (32 * 0)]
  vmovdqu64 [rdi + rcx + (32 * 0)], ymm0
  add rcx, 32
  sub rdx, 32
  test rdx, rdx
  jnz ._loop
  jmp .epi
.jge_16:
  prefetcht1 [rsi + rcx + (16 * 0)]
  prefetcht1 [rdi + rcx + (16 * 0)]
  vmovdqu64 xmm0, [rsi + rcx + (16 * 0)]
  vmovdqu64 [rdi + rcx + (16 * 0)], xmm0
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
