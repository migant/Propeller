{{
   FrequencyMeter.spin
}}
    
VAR
  long  cog
  long  counter

  
PUB Start : Okay

  stop
  okay := cog := cognew(@entry, @counter) + 1


PUB Stop

  if cog
    cogstop(cog~ - 1)
    

PUB GetCounter : Count

  Count := counter


DAT
              org
entry
              mov       frqa, #1

              mov       ctra, ZERO                      ' Turn Off Counter                   
              mov       phsa, ZERO                      ' Reset Pulse Counter
              mov       ctra, ctra_dat                  ' Turn On Counter
              
:loop         mov       t0, phsa
              and       t0, mask
              wrlong    t0, par
              jmp       #:loop


ZERO          long      0

t0            long      0
mask          long      %01111111_11111111_11111111_11111111

ctra_dat      long      %0_01010_000_00000000_000000_000_011111