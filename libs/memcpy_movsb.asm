

[section .text]
global memcpy_movsb
;
; void *memcpy_avx512(void *dst, const void *src, size_t len);
;
memcpy_movsb:
  mov rax, rdi
  mov rcx, rdx
  rep movsb
  ret
