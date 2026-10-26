{{
   Oscilator.spin
}}

  
VAR
  long  cog
  
  long  frequency
  

PUB Start(Freq) : Okay

  stop
  frequency := Freq
  okay := cog := cognew(@entry, @frequency) + 1


PUB Stop

  if cog
    cogstop(cog~ - 1)

    
PUB UpdateFreq(Freq)

  frequency := Freq

      
DAT
              org
              
entry         mov       t0, par
              rdlong    frqa_data, t0

              mov       ctra, NULL
              mov       frqa, frqa_data
              mov       phsa, NULL
              mov       ctra, ctra_data

              mov       dira, #1
              
:loop         rdlong    frqa_data, t0
              mov       frqa, frqa_data                  
              jmp       #:loop


NULL          long      0

frqa_data     long      0
ctra_data     long      %0_00010_011_00000000_000001_000_000000

t0            res       1                