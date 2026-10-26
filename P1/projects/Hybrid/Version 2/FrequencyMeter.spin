{{
   FrequencyMeter.spin
}}
    
VAR
  long  cog
  long  frequency

  
PUB Start : Okay

  stop
  okay := cog := cognew(@entry, @frequency) + 1


PUB Stop

  if cog
    cogstop(cog~ - 1)
    

PUB GetFreq : Freq

  Freq := frequency


DAT
              org
entry
              mov       frqa, #1

              mov       cnt_data, cnt
              add       cnt_data, delta

:loop         mov       ctra, ZERO                    
              mov       phsa, ZERO
              mov       ctra, ctra_dat
              
              waitcnt   cnt_data, delta        

              mov       t0, phsa
              wrlong    t0, par

              jmp       #:loop


ZERO          long      0

t0            long      0

ctra_dat      long      %0_01010_000_00000000_000000_000_011111
cnt_data      long      0
delta         long      80_000_000