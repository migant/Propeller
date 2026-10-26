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


                        mov                     r0, cfg_frqa
                        mov                     frqa, r0
                        or                      dira, dirport
                        mov                     ctra, cfg_ctra

                        wrlong                  dira, par
                        
:loop                   

                        jmp                     #:loop

                     
cfg_ctra                long                    (%00010 << 26) | (%011 << 23) | (7)
dirport                 long                    %1000_0000
cfg_frqa                long                    375809638


r0                      res                     1