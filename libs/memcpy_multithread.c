
/**
 * @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
 * @link https://github.com/ammarfaizi2/memcpy_benchmark
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <stdbool.h>

typedef struct _memcpy_thread {
  pthread_t         thread;
  pthread_mutex_t   mutex;
  bool              has_job;
  void              *src;
  void              *dst;
  size_t            size;
} memcpy_thread;

unsigned int __memcpy_threads_n = 0;
memcpy_thread *__memcpy_threads = NULL;

inline static void *memcpy_worker(void *_mt)
{
  register memcpy_thread *mt = (memcpy_thread *)_mt;

  worker:
  pthread_mutex_lock(&(mt->mutex));
  if (mt->has_job) {
    __asm__ volatile(
      "mov %0, %%rdi;"
      "mov %1, %%rsi;"
      "mov %2, %%rcx;"
      "rep movsb;"
      :
      : "m"(mt->dst), "m"(mt->src), "m"(mt->size)
      : "rdi", "rsi", "rcx"
    );
    mt->has_job = false;
  }
  pthread_mutex_unlock(&(mt->mutex));
  goto worker;

  return NULL;
}


void memcpy_mt_init(register unsigned int n)
{
  int ret;
  __memcpy_threads   = (memcpy_thread *)malloc(sizeof(memcpy_thread) * n);
  __memcpy_threads_n = n;

  for (register unsigned int i = 0; i < n; i++) {
    register memcpy_thread *mt;
    mt = &(__memcpy_threads[i]);
    mt->has_job = false;
    if ((ret = pthread_mutex_init(&(mt->mutex), NULL))) {
      printf("Mutex init failed: %d\n", ret);
      exit(1);
    }
    pthread_mutex_lock(&(mt->mutex));
    pthread_create(&(mt->thread), NULL, memcpy_worker, (void *)mt);
    pthread_detach(mt->thread);
  }
}


void *memcpy_mt_exec(register void *dst, register void *src, register size_t n)
{
  register size_t index       = 0;
  register unsigned int i     = __memcpy_threads_n;
  register unsigned int j     = i;
  register size_t add_index   = n / i;
  register memcpy_thread *mts = __memcpy_threads;

  while (i--) {
    mts[i].dst     = &(((char *)dst)[index]);
    mts[i].src     = &(((char *)src)[index]);
    mts[i].size    = add_index;
    mts[i].has_job = true;
    index += add_index;
    pthread_mutex_unlock(&(mts[i].mutex));
  }
  usleep(1);
  while (j--) {
    pthread_mutex_lock(&(mts[j].mutex));
  }
  return dst;
}


void memcpy_mt_destroy()
{
  register unsigned int n     = __memcpy_threads_n;
  register memcpy_thread *mts = __memcpy_threads;

  for (register unsigned int i = 0; i < n; i++) {
    pthread_mutex_destroy(&(mts[i].mutex));
  }

  free(mts);
  __memcpy_threads_n = 0;
  __memcpy_threads   = NULL;
}
