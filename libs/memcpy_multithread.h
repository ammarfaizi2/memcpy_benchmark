
#ifndef MEMCPY_MULTITHREAD_H
#define MEMCPY_MULTITHREAD_H

void memcpy_mt_init(register unsigned int n);
void *memcpy_mt_exec(void *dst, void *src, size_t n);
void memcpy_mt_destroy();

#endif
