
#include <stdlib.h>
#include <pthread.h>

typedef struct _memcpy_thread {
  pthread_t thread;
  pthread_mutex_t mutex;
  void *src;
  void *dst;
  size_t size;
} memcpy_thread;

memcpy_thread *__memcpy_threads;

static void *memcpy_worker(void *_mt)
{
  register memcpy_thread *mt = (memcpy_thread *)_mt;

  worker:

  pthread_mutex_lock(&(mt->mutex));

  __asm__(
    "mov %0, %%rdi;"
    "mov %1, %%rsi;"
    "mov %2, %%rcx;"
    "rep movsb;"
    :
    : "m"(mt->dst), "m"(mt->src), "m"(mt->size)
    : "rdi", "rsi", "rcx"
  );

  pthread_mutex_unlock(&(mt->mutex));
  goto worker;

  return NULL;
}


void memcpy_init_thread(register unsigned int n)
{
  __memcpy_threads = (memcpy_thread *)malloc(sizeof(memcpy_thread) * n);


  for (register unsigned int i = 0; i < n; i++) {

    register memcpy_thread *mt;
    mt = &(__memcpy_threads[i]);
    pthread_mutex_init(&(mt->mutex), NULL);
    pthread_mutex_lock(&(mt->mutex));
    pthread_create(&(mt->thread), NULL, memcpy_worker, (void *)mt);

  }
}

