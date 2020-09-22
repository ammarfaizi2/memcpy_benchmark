
#ifndef MEMCPY_MULTITHREAD_H
#define MEMCPY_MULTITHREAD_H

void memcpy_mt_init(register unsigned int n);
void *memcpy_mt_exec(void *dst, const void *src, size_t n);
void memcpy_mt_destroy();
void memcpy_mt_set_callback(void *(*callback)(void *dst, const void *src, size_t));

#endif
