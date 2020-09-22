
/**
 * @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
 * @link https://github.com/ammarfaizi2/memcpy_benchmark
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <pthread.h>
#include <stdbool.h>

typedef struct _memcpy_thread {
  pthread_t         thread;
  pthread_mutex_t   mutex;
  pthread_mutex_t   mutex_refresh;
  void              *src;
  void              *dst;
  size_t            len;
  bool              stop;
  bool              has_job;
  bool              is_ready;
} memcpy_thread;

unsigned int __memcpy_threads_n = 0;
memcpy_thread *__memcpy_threads = NULL;

inline static void *__default_internal_mt_memcpy(register void *dst, register const void *src, register size_t len)
{
  __asm__ volatile(
    "mov %0, %%rdi;"
    "mov %1, %%rsi;"
    "mov %2, %%rcx;"
    "rep movsb;"
    :
    : "r"(dst), "r"(src), "r"(len)
    : "rdi", "rsi", "rcx"
  );
  return dst;
}

void *(*internal_mt_memcpy)(void *dst, const void *src, size_t) = __default_internal_mt_memcpy;

inline static void *memcpy_worker(void *_mt)
{
  register memcpy_thread *mt = (memcpy_thread *)_mt;

  mt->is_ready = true;

  worker:
  pthread_mutex_lock(&(mt->mutex));

  if (mt->has_job) {
    internal_mt_memcpy(mt->dst, mt->src, mt->len);
    mt->has_job  = false;
  }

  pthread_mutex_unlock(&(mt->mutex));

  if (mt->stop) goto ret;

  pthread_mutex_lock(&(mt->mutex_refresh));
  pthread_mutex_unlock(&(mt->mutex_refresh));

  goto worker;

ret:
  mt->is_ready = false;
  return NULL;
}


void memcpy_mt_init(register unsigned int n)
{
  n--;

  register int ret;
  register unsigned int i;
  register memcpy_thread *mts = (memcpy_thread *)malloc(sizeof(memcpy_thread) * n);

  for (i = 0; i < n; i++) {
    mts[i].is_ready = false;
    mts[i].has_job  = false;
    mts[i].stop     = false;

    if ((ret = pthread_mutex_init(&(mts[i].mutex), NULL))) {
      printf("Pthread mutex init failed: %d\n", ret);
      exit(1);
    }

    if ((ret = pthread_mutex_init(&(mts[i].mutex_refresh), NULL))) {
      printf("Pthread mutex_refresh init failed: %d\n", ret);
      exit(1);
    }

    pthread_mutex_lock(&(mts[i].mutex));
    pthread_create(&(mts[i].thread), NULL, memcpy_worker, (void *)&(mts[i]));
    pthread_detach(mts[i].thread);
  }

  __memcpy_threads   = mts;
  __memcpy_threads_n = n;

  /* Make sure the threads are all ready. */
  for (i = 0; i < n; i++) {
    while (!mts[i].is_ready) usleep(100);
  }
}


void *memcpy_mt_exec(register void *dst, register void *src, register size_t len)
{
  register unsigned int i;
  register unsigned int n     = __memcpy_threads_n;
  register memcpy_thread *mts = __memcpy_threads;
  register size_t add_index   = len / (n + 1);
  register size_t index       = 0;

  for (i = 0; i < n; i++) {
    mts[i].dst     = (void *)&(((char *)dst)[index]);
    mts[i].src     = (void *)&(((char *)src)[index]);
    mts[i].len     = add_index;
    mts[i].has_job = true;
    index         += add_index;
    pthread_mutex_unlock(&(mts[i].mutex));
    pthread_mutex_lock(&(mts[i].mutex_refresh));
  }

  internal_mt_memcpy(
    (void *)&(((char *)dst)[index]),
    (void *)&(((char *)src)[index]),
    add_index
  );

  for (i = 0; i < n; i++) {
    pthread_mutex_lock(&(mts[i].mutex));
  }

  for (i = 0; i < n; i++) {
    pthread_mutex_unlock(&(mts[i].mutex_refresh));
  }

  return dst;
}


void memcpy_mt_destroy()
{
  register unsigned int n     = __memcpy_threads_n;
  register memcpy_thread *mts = __memcpy_threads;

  for (register unsigned int i = 0; i < n; i++) {
    mts[i].stop    = true;
    mts[i].has_job = false;
    pthread_mutex_unlock(&(mts[i].mutex));
  }

  for (register unsigned int i = 0; i < n; i++) {
    /* Wait until the thread reaches epilogue. */
    while (mts[i].is_ready) usleep(1000);
    pthread_mutex_destroy(&(mts[i].mutex));
  }

  free(mts);
  __memcpy_threads_n = 0;
  __memcpy_threads   = NULL;
}


void memcpy_mt_set_callback(void *(*callback)(void *dst, const void *src, size_t))
{
  internal_mt_memcpy = callback;
}
