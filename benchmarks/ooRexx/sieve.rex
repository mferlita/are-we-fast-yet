#!/usr/bin/env rexx

::CLASS Sieve SUBCLASS Benchmark
  ::METHOD benchmark
    flags = Array~of(5000, .true)
    sieve(flags, 5000)

  ::METHOD verify_result
    USE ARG result
    result == 669

  ::METHOD sieve
    USE ARG flags, size
    prime_count = 0

    LOOP i = 2 TO size
      IF flags[i - 1] THEN DO
        prime_count += 1
        k = i + i
        DO WHILE k <= size
          flags[k - 1] = .false
          k += i
        END
      END
    END

    RETURN prime_count

::REQUIRES 'benchmark.rex'
