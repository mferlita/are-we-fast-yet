#!/usr/bin/env rexx

::CLASS Benchmark PUBLIC
  ::METHOD innerBenchmarkLoop
    USE ARG innerIterations

    DO iteration = 1 TO innerIterations
      IF \self~verifyResult(self~benchmark) THEN
        RETURN .false
    END

    RETURN .true

  ::METHOD benchmark
    RAISE SYNTAX 88.900 ARRAY ('subclass responsibility')

  ::METHOD verifyResult
    USE ARG result

    RAISE SYNTAX 88.900 ARRAY ('subclass responsibility')
