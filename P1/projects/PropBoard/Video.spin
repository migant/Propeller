''***************************************
''*  VGA Text Demo v1.0                 *
''*  Author: Chip Gracey                *
''*  Copyright (c) 2006 Parallax, Inc.  *
''*  See end of file for terms of use.  *
''***************************************


VAR
  long cog
  

PUB start(frq) : okay

'' Start PLL driver - starts a cog
'' returns false if no cog available
''

  stop
  okay := cog := cognew(@entry, frq) + 1

  
PUB stop

'' Stop FrequencyMeter driver - frees a cog

  if cog
    cogstop(cog~ - 1)

   
DAT


                        org

entry

                        mov                     ctra, #0
                        mov                     ctrb, #0

                        mov                     frqa, #0
                        mov                     frqb, #0

                        mov                     phsa, #0
                        mov                     phsb, #0
:loop                   

                        jmp                     #:loop

                     
cfg_ctra                long                    (%00010 << 26) | (%011 << 23) | (7)
dirport                 long                    %0000_0001
cfg_frqa                long                    37580963                               '380845487

                                                                                                        
r0                      res                     1