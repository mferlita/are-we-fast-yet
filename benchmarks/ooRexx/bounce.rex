-- This code is derived from the SOM benchmarks, see AUTHORS.md file.
--
-- Copyright (c) 2015-2016 Stefan Marr <git@stefan-marr.de>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the 'Software'), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

/* Directives */
::REQUIRES 'benchmark.rex'
::REQUIRES 'som.rex'
--------------------------------------------------------------------------------
::CLASS Bounce SUBCLASS Benchmark
  ::METHOD benchmark
    random = RANDOM()
    ballCount = 100
    bounces    = 0
    balls      = .Array~new(ballCount)

    DO i = 1 TO ballCount
      balls[i] = .ball~new(random)
    END

    DO 50
      DO ball OVER balls
        IF .ball~bounce THEN bounces += 1
      END
    END
    RETURN bounces

  ::METHOD verifyResult PUBLIC
    USE ARG result
    RETURN result == 1331
--------------------------------------------------------------------------------
::CLASS Ball PUBLIC
  ::ATTRIBUTE x
  ::ATTRIBUTE y
  ::ATTRIBUTE xVel
  ::ATTRIBUTE yVel

  ::METHOD initialize
    USE ARG random
      self~x = random~next~modulo(500)
      self~y = random~next~modulo(500)

      self~xVel = (random~next~modulo(300)) - 150
      self~yVel = (random~next~modulo(300)) - 150

  ::METHOD bounce
    xLimit = yLimit = 500
    bounced = .false

    self~x += self~xVel
    self~y += self~yVel

    IF self~x > xLimit THEN DO
      self~x = xLimit
      self~xVel = 0 - self~xVel~abs
      bounced = .true
    END

    IF self~x < 0 THEN DO
      self~x = 0
      self~xVel = self~xVel~abs
      bounced = true
    END

    IF self~y > yLimit THEN DO
      self~y = yLimit
      self~yVel = 0 - self~yVel.abs
      bounced = .true
    END

    IF self~y < 0 THEN DO
      self~y = 0
      self~yVel = self~yVel.abs
      bounced = .true
    END
    RETURN bounced
