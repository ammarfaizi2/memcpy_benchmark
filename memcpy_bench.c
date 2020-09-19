
/**
 * @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
 *
 * Benchmark memcpy.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <sys/time.h>

#define MEM_ALLOC (1024 * 1024 * 512)
#define START_BENCHMARK do {                              \
    printf("Initializing source data...\n");              \
    fflush(stdout);                                       \
    memset(src, 'a', MEM_ALLOC);                          \
    start_time = get_timestamp();                         \
  } while (0)

#define END_BENCHMARK do {                                \
    end_time = get_timestamp();                           \
    double secs = (end_time - start_time) / 1000000.0L;   \
    printf("%0.10lf seconds\n", secs);                    \
    printf("Verificating copied data...\n");              \
    fflush(stdout);                                       \
    assert(!memcmp(dst, src, MEM_ALLOC));                 \
  } while (0)

void *memcpy_avx512(void *dst, const void *src, size_t len);
void *memcpy_movsb(void *dst, const void *src, size_t len);

typedef unsigned long long timestamp_t;

static void
usage(char *app) {
  printf("Usage: %s 1|2|3\n", app);
}

static timestamp_t
get_timestamp()
{
  struct timeval now;
  gettimeofday(&now, NULL);
  return now.tv_usec + (timestamp_t)now.tv_sec * 1000000;
}


int
main(int argc, char *argv[])
{

  if (argc != 2) {
    usage(argv[0]);
    return 1;
  }

  timestamp_t start_time, end_time;
  char *dst = (char *)malloc(MEM_ALLOC);
  char *src = (char *)malloc(MEM_ALLOC);

  switch (argv[1][0]) {
    case '1':
      printf("Benchmarking memcpy...\n");
      START_BENCHMARK;
      memcpy(dst, src, MEM_ALLOC);
      END_BENCHMARK;
      break;

    case '2':
      printf("Benchmarking memcpy_avx512...\n");
      START_BENCHMARK;
      memcpy_avx512(dst, src, MEM_ALLOC);
      END_BENCHMARK;
      break;

    case '3':
      printf("Benchmarking memcpy_movsb...\n");
      START_BENCHMARK;
      memcpy_movsb(dst, src, MEM_ALLOC);
      END_BENCHMARK;
      break;

    default:
      usage(argv[0]);
      free(dst);
      free(src);
      return 1;
  }
  printf("OK!\n");
  return 0;
}
