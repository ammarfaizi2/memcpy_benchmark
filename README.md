# Memcpy Benchmark
Which is the best `memcpy`?

# How to use?
```sh
# Clone the repository.
git clone https://github.com/ammarfaizi2/memcpy_benchmark;
cd memcpy_benchmark;
make;

# Force CPU to use max freq.
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;

# Run the benchmark.
./memcpy_bench 1 # Benchmark built in memcpy from libc
./memcpy_bench 2 # Benchmark memcpy_avx256
./memcpy_bench 3 # Benchmark memcpy_avx512
./memcpy_bench 4 # Benchmark memcpy_movsb
```

# License
This is free and unencumbered software released into the public domain, thanks.

