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
                        mov     vcfg, vcfg_data1

:superfield
                        mov     vscl, vscl_data1
                        waitvid Pulse, Pixels1
                        
                        mov     vscl, vscl_data2
                        waitvid Pulse, Pixels2
                        
                        jmp     #:superfield

Pulse                   long    %00000011_00000000_00000000_00000000                        
Pixels1                 long    %11000000_00000000_00000000_00000000
Pixels2                 long    %00000000_00000000_00000000_00000000

dira_data               long    %00000000_11111111_00000000_00000000
ctra_data               long    %0_00001_101_00000000_011111_000_010000
frqa_data               long    335_544_320                                   ' 25Mhz Pixel Clock
{ VGA Mode, 4 color mode }
vscl_data1              long    %000000000000_00000001_000000010000           ' 16 Pixels / Frame
vscl_data2              long    %000000000000_00000001_100000000000           ' 2048 Pixels / Frame
vcfg_data1              long    %0_01_1_0_0_000_00000000000_010_0_11111111


                        fit     $100