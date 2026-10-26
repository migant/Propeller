{{
   Video_Osc.spin
}}

  
VAR
  long  cog
  

PUB Start : Okay

  stop
  okay := cog := cognew(@entry, 0) + 1


PUB Stop

  if cog
    cogstop(cog~ - 1)
    
    
DAT
                        org

entry
                        mov     dira, dira_data
                        mov     frqa, frqa_data
                        mov     ctra, ctra_data

                        mov     vcfg, vcfg_data
                        mov     vscl, vscl_data



:mainloop               waitvid Colors, Pixels_vs2
                        jmp     #:mainloop

:frame
                        mov     y, #5     
                        
:loop1                  waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1

                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1

                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1


                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs1
                        waitvid Colors, Pixels_vs2

                        djnz     y, #:loop1




                        mov      y, dy
:loop2
                        waitvid Colors, Pixels_hs1
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2

                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2

                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2

                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
                        waitvid Colors, Pixels_hs2
          
                        djnz     y, #:loop2
                        
                        jmp      #:frame

                        
y                       res     1

dy                      long    620


Pixels_vs1              long    %00000000_00000000_00000000_00000000
Pixels_vs2              long    %00000000_11111111_00000000_00000000

Pixels_hs1              long    %11111111_11110000_00001111_11111111
Pixels_hs2              long    %11111111_11111111_11111111_11111111


Pixels1                 long    %10000000_00000000_00000000_00000000

Colors                  long    %00000000_00000000_00000001_00000000



dira_data               long    %00001111_00000000_00000000_00000000
frqa_data               long    362_387_865
ctra_data               long    %0_00001_101_00000000_000000_000_010000

vcfg_data               long    %0_10_0_0_0_000_00000000000_011_0_00001111
vscl_data               long    %000000000000_00000001_000000100000
                                 

                        fit     $100