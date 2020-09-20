# Memcpy Benchmark
Which is the best `memcpy`?

# How to use?
```sh
# Install nasm and gcc.
sudo apt install nasm gcc -y;

# Clone the repository.
git clone https://github.com/ammarfaizisudo nice -n -20 ./memcpy_benchmark;
cd memcpy_benchmark;
make;

# Allow CPU to use max freq.
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;

# Run the benchmark.
sudo nice -n -20 ./memcpy_bench 1 # Benchmark built in memcpy from libc
sudo nice -n -20 ./memcpy_bench 2 # Benchmark memcpy_avx256
sudo nice -n -20 ./memcpy_bench 3 # Benchmark memcpy_avx512
sudo nice -n -20 ./memcpy_bench 4 # Benchmark memcpy_movsb
```

# License
This is free and unencumbered software released into the public domain, thanks.
