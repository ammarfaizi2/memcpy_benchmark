
/**
 * @author Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
 * @licence https://github.com/ammarfaizi2/memcpy_benchmark
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
#define TEST_COUNT 10

#define START_BENCHMARK(LABEL) do {                         \
    uint32_t i = 0;                                         \
    total = min = max = 0;                                  \
    chk_##LABEL:                                            \
    src = (char *)malloc(MEM_ALLOC);                        \
    dst = (char *)malloc(MEM_ALLOC);                        \
    printf("Initializing source data...\n");                \
    fflush(stdout);                                         \
    memset(src, 'a', MEM_ALLOC);                            \
    start_time = get_timestamp();


#define END_BENCHMARK(LABEL)                                \
    end_time = get_timestamp();                             \
    double secs = (end_time - start_time) / 1000000.0L;     \
    printf("%0.10lf seconds\n", secs);                      \
    printf("Verificating copied data...\n");                \
    fflush(stdout);                                         \
    total += secs;                                          \
    min = i ? (min > secs ? secs : min) : secs;             \
    max = i ? (max < secs ? secs : max) : secs;             \
    assert(!memcmp(dst, src, MEM_ALLOC));                   \
    free(dst); free(src);                                   \
    if (i++ < TEST_COUNT) goto chk_##LABEL;                 \
    printf("Max\t: %0.10lf\n", max);                        \
    printf("Min\t: %0.10lf\n", min);                        \
    printf("Avg\t: %0.10lf\n", total / TEST_COUNT);         \
    printf("Total\t: %0.10lf\n", total);                    \
  } while (0)

void *memcpy_avx256(void *dst, const void *src, size_t len);
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

  double total, min, max;
  char *dst = NULL, *src = NULL;
  timestamp_t start_time, end_time;

  switch (argv[1][0]) {
    case '1':
      printf("Benchmarking memcpy...\n");
      START_BENCHMARK(memcpy);
      memcpy(dst, src, MEM_ALLOC);
      END_BENCHMARK(memcpy);
      break;

    case '2':
      printf("Benchmarking memcpy_avx256...\n");
      START_BENCHMARK(memcpy_avx256);
      memcpy_avx256(dst, src, MEM_ALLOC);
      END_BENCHMARK(memcpy_avx256);
      break;

    case '3':
      printf("Benchmarking memcpy_avx512...\n");
      START_BENCHMARK(memcpy_avx512);
      memcpy_avx512(dst, src, MEM_ALLOC);
      END_BENCHMARK(memcpy_avx512);
      break;

    case '4':
      printf("Benchmarking memcpy_movsb...\n");
      START_BENCHMARK(memcpy_movsb);
      memcpy_movsb(dst, src, MEM_ALLOC);
      END_BENCHMARK(memcpy_movsb);
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
