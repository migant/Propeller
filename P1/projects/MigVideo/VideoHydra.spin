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

                        mov                     frqa, cfg_frqa
                        mov                     ctra, cfg_ctra

                        mov                     vscl, vscl_h
                        mov                     vcfg, v_cfg

                        or                      dira, dirport


:superfield

                        mov                     line, #312-4
:hsync                  
                        mov                     vscl, vscl_h
                        waitvid                 color_h, pix_h

                        mov                     vscl, vscl_vis
                        waitvid                 color_vis, pix_vis

                        djnz                    line, #:hsync


                        jmp                     #:superfield


                        mov                     line, #(4)
                        mov                     vscl, vscl_v
:vsync
                        waitvid                 color_v, pix_v
                        djnz                    line, #:vsync

                        jmp                     #:superfield




line                    long                    0

vscl_v                  long                    (14 << 12) | 448
color_v                 long                    %00000000_00000001
pix_v                   long                    %00000000_00000000_00000000_0000001


vscl_h                  long                    (3 << 12) | 96
color_h                 long                    %00000001_00000000
pix_h                   long                    %00001111_11111111_11111111_11110000


vscl_vis                long                    (11 << 12) | 352
color_vis               long                    %00000110_00000100
pix_vis                 long                    %00000000_11111111_00000000_11111111


                                                                               
dirport                 long                    %00001111_00000000_00000000_00000000
v_cfg                   long                    (%10 << 29) | (%0 << 28) | (%00 << 26) | (%000 << 23) | (%011 << 9) | (%00001111)

cfg_ctra                long                    (%00001 << 26) | (%011 << 23)
cfg_frqa                long                    375809638 / 2


r0                      res                     1