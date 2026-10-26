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

:loop                   waitvid Colors, Pixels1

                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0

                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0

                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0
                        waitvid Colors, Pixels0

                        jmp     #:loop
                        

Pixels0                 long    %00000000_00000000_00000000_00000000
Pixels1                 long    %10000000_00000000_00000000_00000000

Colors                  long    %00000000_00000000_11111111_00000000



dira_data               long    %00000000_11111111_00000000_00000000
frqa_data               long    362_387_865
ctra_data               long    %0_00001_101_00000000_000000_000_010000

vcfg_data               long    %0_01_0_0_0_000_00000000000_010_0_11111111
vscl_data               long    %000000000000_00000001_000000100000


                        fit     $100