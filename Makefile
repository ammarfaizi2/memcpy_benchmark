
all: memcpy_bench

memcpy_avx512.o: memcpy_avx512.asm
	nasm -felf64 memcpy_avx512.asm -o memcpy_avx512.o

memcpy_movsb.o: memcpy_movsb.asm
	nasm -felf64 memcpy_movsb.asm -o memcpy_movsb.o

memcpy_bench: memcpy_avx512.o memcpy_movsb.o memcpy_bench.c
	gcc -Wall -O0 memcpy_avx512.o memcpy_movsb.o memcpy_bench.c -o memcpy_bench

clean:
	rm -vf *.o memcpy_bench
